//
//  AudioPlayerLayout.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 24/08/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension AudioPlayerController {
    
    func setupLayout() {
        
        pauseButton.isHidden = true
        view.backgroundColor = .white
        
        //Setting size for buttons.
        [echoButton,snailButton,rabbitButton,reverbButton,chipmunkButton,darthVaderButton,pauseButton].forEach {
            $0.sized(with: CGSize.init(width: 100, height: 100))
        }
        
        // Creating Stacks
        let firstHorizontalStack = UIStackView(axis: .horizontal, spacing: 0, distribution: .fillEqually)
        [snailButton,rabbitButton,chipmunkButton].forEach {firstHorizontalStack.addArrangedSubview($0)}
        
        let secondHorizontalStack = UIStackView(axis: .horizontal, spacing: 0, distribution: .fillEqually)
        [darthVaderButton,echoButton,reverbButton].forEach { secondHorizontalStack.addArrangedSubview($0)}
        
        entireStack.alignment = .center
        
        // Adding Views
        [titleLabel,firstHorizontalStack,secondHorizontalStack, recordNewSoundButton ].forEach { entireStack.addArrangedSubview($0)}
        [wallpaperImageView, entireStack, pauseButton].forEach { view.addSubview($0)}
        
        // Wallpaper
        wallpaperImageView.anchorEqualTo(view: view)

        // Entire Stack
        entireStack.centeredTo(view: view)
        entireStack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 2).isActive = true
        entireStack.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 2).isActive = true
        
        pauseButton.centeredTo(view: view)

        }
}

