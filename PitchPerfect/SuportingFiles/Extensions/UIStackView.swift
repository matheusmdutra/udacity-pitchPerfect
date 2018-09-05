//
//  UIStackView.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 25/08/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init(axis: UILayoutConstraintAxis, spacing: CGFloat, distribution: UIStackViewDistribution, alignment: UIStackViewAlignment? = nil) {
        self.init()
        self.spacing = spacing
        self.axis = axis
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
        if let alignment = alignment {
            self.alignment = alignment
        }
    }
}
