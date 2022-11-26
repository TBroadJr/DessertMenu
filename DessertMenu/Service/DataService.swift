//
//  DataService.swift
//  DessertMenu
//
//  Created by Tornelius Broadwater, Jr on 11/22/22.
//

import UIKit

class DataService {
    static let instance = DataService()
    
    private var recipeIDs: [Int] = [Int]()
    private var recipes: [Recipe] = [Recipe]()
    private var cache = NSCache<NSString, UIImage>()
    
    public func getRecipes() async {
        guard recipes.count == 0 else {
            for item in recipes {
                cacheImage(recipe: item)
                sendUpdateNotification()
            }
            return
        }
        await getRecipeIDs()
        await getRecipeInfo()
    }
    
    public func getRecipeArray() -> [Recipe] {
        return recipes
    }
    
    public func getCacheImage(imageName: String) -> UIImage? {
        let name = NSString(string: imageName)
        if let image = cache.object(forKey: name) {
            return image
        }
        return nil
    }
    
    private func getRecipeIDs() async {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let recipeData = try JSONDecoder().decode(RecipeID.self, from: data)
            for item in recipeData.meals {
                if let id = Int(item.idMeal) {
                    recipeIDs.append(id)
                }
            }
        } catch {
            print(error)
        }
    }
    
    private func getRecipeInfo() async {
        for item in recipeIDs {
            guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(item)") else { return }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let recipe = try JSONDecoder().decode(Recipes.self, from: data)
                var array = [Recipe]()
                for item in recipe.meals {
                    cacheImage(recipe: item)
                    array.append(item)
                    sendUpdateNotification()
                }
                recipes.append(contentsOf: array)
            } catch {
                print(error)
            }
        }
    }
    
    private func sendUpdateNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Constants.NotificationName.recipeDataUpdate, object: nil)
    }
    
    private func cacheImage(recipe: Recipe) {
        guard let imageURL = URL(string: recipe.imageURL) else { return }
        if let data = try? Data(contentsOf: imageURL) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.cache.setObject(image, forKey: NSString(string: recipe.imageURL))
                }
            }
        }
    }
}
