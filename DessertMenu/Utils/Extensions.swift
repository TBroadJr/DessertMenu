//
//  Extensions.swift
//  DessertMenu
//
//  Created by Tornelius Broadwater, Jr on 11/23/22.
//

import UIKit

enum PinType {
    case center
}

extension UIView {
    func pin(to superView: UIView, pinType: PinType) {
        switch pinType {
        case .center:
            NSLayoutConstraint.activate([
                centerYAnchor.constraint(equalTo: superView.centerYAnchor),
                centerXAnchor.constraint(equalTo: superView.centerXAnchor)
            ])
        }
    }
}
