//
//  UIImageView.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 29/07/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    convenience init(image: UIImage, contentMode: UIViewContentMode, size: CGSize?) {
        self.init()
        self.image = image
        self.contentMode = contentMode
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        
        if let height = size?.height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let widht = size?.width  {
            self.widthAnchor.constraint(equalToConstant: widht).isActive = true
        }
    }
}
