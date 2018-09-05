//
//  UIFont.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 29/07/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    func retrieveAppFont(named: AppRules.Fonts) -> UIFont {
        switch named {
        case .normal:
            return UIFont.systemFont(ofSize: 20)
        case .normalBold:
            return UIFont.boldSystemFont(ofSize: 20)
        case .small:
            return UIFont.systemFont(ofSize:  13)
        case .headerBold:
            return UIFont.boldSystemFont(ofSize: 25)
        case .header:
            return UIFont.systemFont(ofSize: 25)
        default:
            return UIFont.systemFont(ofSize: 15)
        }
    }

}
