//
//  Constants.swift
//  DessertMenu
//
//  Created by Tornelius Broadwater, Jr on 11/23/22.
//

import Foundation

enum Constants {
    enum CellReuseID {
        static let recipeCell = "recipeCell"
    }
    
    enum NotificationName {
        static let recipeDataUpdate = Notification.Name("recipeDataUpdate")
        static let reloadImages = Notification.Name("reloadImages")
    }
}
