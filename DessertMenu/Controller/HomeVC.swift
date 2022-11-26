//
//  HomeVC.swift
//  DessertMenu
//
//  Created by Tornelius Broadwater, Jr on 11/22/22.
//

import UIKit

class HomeVC: UIViewController {
    
    let dataService = DataService.instance
    
    private let chefLogoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chefLogo")
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var retrieveRecipesButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .systemPink
        button.configuration?.title = "Retrieve Recipes"
        button.configuration?.image = UIImage(systemName: "arrow.right")
        button.configuration?.imagePlacement = .trailing
        button.configuration?.imagePadding = 10
        button.addTarget(self, action: #selector(goToRecipeVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "Dessert Menu"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    }
}

// MARK: - Constraints
extension HomeVC {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chefLogoImageSetup()
        nextButtonSetup()
    }
    
    private func chefLogoImageSetup() {
        view.addSubview(chefLogoImage)
        NSLayoutConstraint.activate([
            chefLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chefLogoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height * -0.05),
            chefLogoImage.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            chefLogoImage.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8)
        ])
    }
    
    private func nextButtonSetup() {
        view.addSubview(retrieveRecipesButton)
        NSLayoutConstraint.activate([
            retrieveRecipesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retrieveRecipesButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height / 3),
            retrieveRecipesButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            retrieveRecipesButton.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.06)
        ])
    }
}

// MARK: - Actions
extension HomeVC {
    @objc private func goToRecipeVC() {
        Task {
            await dataService.getRecipes()
        }
        let recipeVC = RecipeVC()
        navigationController?.pushViewController(recipeVC, animated: true)
    }
}

