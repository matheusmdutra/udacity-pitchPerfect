//
//  UIView.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 29/07/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    convenience init(backColor: UIColor) {
        self.init()
        self.backgroundColor = backColor
    }
    func top(to: NSLayoutYAxisAnchor, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        self.topAnchor.constraint(equalTo: to, constant: padding).isActive = true
    }
    
    func bottom(to: NSLayoutYAxisAnchor, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        self.bottomAnchor.constraint(equalTo: to, constant: -padding).isActive = true
    }
    
    func leading(to: NSLayoutXAxisAnchor, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        self.leadingAnchor.constraint(equalTo: to, constant: padding).isActive = true
    }
    
    func trailing(to: NSLayoutXAxisAnchor, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        self.trailingAnchor.constraint(equalTo: to, constant: -padding).isActive = true
    }
    
    func centeredX(to: UIView, padding: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        self.centerXAnchor.constraint(equalTo: to.centerXAnchor,constant: padding ?? 0).isActive = true
    }
    
    func centeredY(to: UIView, padding: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        self.centerYAnchor.constraint(equalTo: to.centerYAnchor, constant: padding ?? 0).isActive = true
    }
    
    func centeredTo(view: UIView, paddingX: CGFloat? = nil, paddingY: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false

        self.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: paddingX ?? 0).isActive = true
        self.centerYAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.centerYAnchor, constant: paddingY ?? 0).isActive = true
        
    }
    
    func anchorEqualTo(view: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
        
    }
    
    
    func sized(with: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false

        if with.height != 0 {
            self.heightAnchor.constraint(equalToConstant: with.height).isActive = true
        }
        
        if with.width != 0 {
            self.widthAnchor.constraint(equalToConstant: with.width).isActive = true
        }
    }
    
    
    func simpleAnchor(top: NSLayoutYAxisAnchor? , bottom: NSLayoutYAxisAnchor? , left: NSLayoutXAxisAnchor? , right: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            
        }
        
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
        }
        
    }
    
    func complexAnchor(top: NSLayoutYAxisAnchor? = nil , bottom: NSLayoutYAxisAnchor? = nil , left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerYto: UIView? = nil, centerXto:  UIView? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            
        }
        
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if let centerXto = centerXto {
            centerXAnchor.constraint(equalTo: centerXto.centerXAnchor).isActive = true
            
        }
        
        if let centerYto = centerYto {
            centerYAnchor.constraint(equalTo: centerYto.centerYAnchor).isActive = true
        }
    }
    
    
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leadingAnchor
        }else {
            return self.leftAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.trailingAnchor
        }else {
            return self.rightAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
    
}
