//
//  RecipeVC.swift
//  DessertMenu
//
//  Created by Tornelius Broadwater, Jr on 11/22/22.
//

import UIKit

class RecipeVC: UIViewController {
    
    let dataService = DataService.instance
    
    private var spinner: UIActivityIndicatorView = {
       let spinner = UIActivityIndicatorView()
        spinner.style = .large
        return spinner
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cyan
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RecipeCell.self, forCellReuseIdentifier: Constants.CellReuseID.recipeCell)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "Recipes"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        setTableViewDelegates()
        spinnerAnimate()
        
        let noticicationCenter = NotificationCenter.default
        noticicationCenter.addObserver(self, selector: #selector(updateView), name: Constants.NotificationName.recipeDataUpdate, object: nil)
        noticicationCenter.addObserver(self, selector: #selector(reloadCacheImages), name: Constants.NotificationName.reloadImages, object: nil)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func spinnerAnimate() {
        if dataService.getRecipeArray().count == 0 {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
}

// MARK: - Constraints
extension RecipeVC {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewSetup()
        spinnerSetup()
    }
    
    private func spinnerSetup() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.pin(to: view, pinType: .center)
    }
    
    private func tableViewSetup() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        ])
    }
}

// MARK: - TableView Setup
extension RecipeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.getRecipeArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseID.recipeCell, for: indexPath) as? RecipeCell {
            cell.configureCell(recipe: dataService.getRecipeArray()[indexPath.row], cachedImage: dataService.getCacheImage(imageName: dataService.getRecipeArray()[indexPath.row].imageURL))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipe = dataService.getRecipeArray()[indexPath.row]
        let detailVC = DetailVC()
        detailVC.recipe = recipe
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Actions
extension RecipeVC {
    @objc private func updateView() {
        Task {
            spinner.stopAnimating()
            tableView.reloadData()
        }
    }
    
    @objc public func reloadCacheImages() {
        Task {
            await dataService.getRecipes()
        }
    }
}

