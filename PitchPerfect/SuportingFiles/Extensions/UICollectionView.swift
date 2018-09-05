//
//  UICollectionView.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 25/08/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    convenience init(scrollDirection: UICollectionViewScrollDirection, backColor: UIColor, contentMode: UIViewContentMode  ) {
        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = scrollDirection
        self.init(frame: .zero, collectionViewLayout: myLayout)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backColor
        self.contentMode = contentMode
    }
}
