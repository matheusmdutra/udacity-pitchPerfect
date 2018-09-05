//
//  MainScreenLayout.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 29/07/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit

extension RecordingAudioViewController {
    
    func setupLayout() {
        view.backgroundColor = .white
        let stackView = UIStackView(axis: .vertical, spacing: 30, distribution: .fill)
        
        //Adding Views
        [recordButton,recordingLabel].forEach{stackView.addArrangedSubview($0)}
        
        //wallpaper
        [wallpaperImageView, stackView].forEach{view.addSubview($0)}
        wallpaperImageView.anchorEqualTo(view: view)

        //stack
        stackView.centeredTo(view: view)
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor).isActive = true
      }
}
