//
//  UILabel.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 29/07/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(text: String, textColor: UIColor?, font: AppRules.Fonts ,numberOfLines: Int) {
        self.init()
        self.adjustsFontSizeToFitWidth = true
        self.text = text
        self.numberOfLines = numberOfLines
        if let textColor = textColor { self.textColor = textColor }
        self.font = UIFont().retrieveAppFont(named: font)
    }
    
    func centered() {
        self.textAlignment = .center
    }
    
}
