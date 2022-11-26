//
//  DetailVC.swift
//  DessertMenu
//
//  Created by Tornelius Broadwater, Jr on 11/24/22.
//

import UIKit

class DetailVC: UIViewController {
    
    let dataService = DataService.instance
    var recipe: Recipe!
    
    private var recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Ingredients", "Instructions"])
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 10
        control.clipsToBounds = true
        control.selectedSegmentTintColor = .systemPink
        control.addTarget(self, action: #selector(handleSegmentedControlChange), for: .valueChanged)
        return control
    }()
    
    private var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = recipe.name
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}

// MARK: - Constraints
extension DetailVC {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recipeImageSetup()
        segmentedControlSetup()
        customViewSetup()
        textLabelSetup()
    }
    
    private func recipeImageSetup() {
        view.addSubview(recipeImage)
        recipeImage.image = dataService.getCacheImage(imageName: recipe.imageURL)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
            recipeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeImage.heightAnchor.constraint(equalToConstant: view.bounds.height / 5),
            recipeImage.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.75)
        ])
    }
    
    private func segmentedControlSetup() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func customViewSetup() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.95),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        ])
    }
        
    private func textLabelSetup() {
        view.addSubview(textLabel)
        handleSegmentedControlChange()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            textLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            textLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
            textLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - Actions
extension DetailVC {
    @objc private func handleSegmentedControlChange() {
        textLabel.text = ""
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            for i in recipe.ingredientsArray {
                textLabel.text = textLabel.text! + i + "\n"
            }
            
        case 1:
            textLabel.text = recipe.instructions
            
        default:
            break
        }
    }
}
