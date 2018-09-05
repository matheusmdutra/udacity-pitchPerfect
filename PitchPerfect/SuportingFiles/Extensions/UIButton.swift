//
//  UIButton.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 29/07/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(image: UIImage? = nil, text: String? = nil, font: AppRules.Fonts? = nil) {
        self.init()
        if let image = image {self.setImage(image, for: .normal)}
        if let text = text {self.setTitle(text, for: .normal)}
        if let font = font {self.titleLabel?.font = UIFont().retrieveAppFont(named: font) }
    }
}
