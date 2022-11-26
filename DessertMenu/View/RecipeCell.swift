//
//  RecipeCell.swift
//  DessertMenu
//
//  Created by Tornelius Broadwater, Jr on 11/23/22.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    private var recipeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private var blurEffectView: UIVisualEffectView = {
        let effect = UIVisualEffectView()
        let blur = UIBlurEffect(style: .systemUltraThinMaterialLight)
        effect.effect = blur
        effect.alpha = 1
        effect.layer.cornerRadius = 20
        effect.clipsToBounds = true
        return effect
    }()
    
    private var recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var recipeIngredientCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cyan
        addSubview(recipeImageView)
        addSubview(blurEffectView)
        addSubview(recipeTitleLabel)
        addSubview(recipeIngredientCountLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(recipe: Recipe, cachedImage: UIImage?) {
        configureRecipeImageView(recipe: recipe, cachedImage: cachedImage)
        configureRecipeBlurEffectView()
        configureRecipeTitleLabel(recipe: recipe)
        configureRecipeIngredientCountLabel(recipe: recipe)
    }
    
    private func configureRecipeImageView(recipe: Recipe, cachedImage: UIImage?) {
        if let image = cachedImage {
            recipeImageView.image = image
        } else {
            recipeImageView.image = UIImage(systemName: "photo")
        }
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * 0.05),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bounds.width * 0.05),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: bounds.width * -0.05),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bounds.height * -0.05)
        ])
    }
    
    private func configureRecipeBlurEffectView() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * 0.65),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bounds.width * 0.05),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: bounds.width * -0.25),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bounds.height * -0.05)
        ])
    }
    
    private func configureRecipeTitleLabel(recipe: Recipe) {
        recipeTitleLabel.text = recipe.name
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * 0.70),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bounds.width * 0.1),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: bounds.width * -0.3)
        ])
    }
    
    private func configureRecipeIngredientCountLabel(recipe: Recipe) {
        recipeIngredientCountLabel.text = "Ingredient Count: \(recipe.ingredientsArray.count)"
        recipeIngredientCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeIngredientCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.height * 0.80),
            recipeIngredientCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bounds.width * 0.1),
            recipeIngredientCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: bounds.width * -0.3)
        ])
    }
}
