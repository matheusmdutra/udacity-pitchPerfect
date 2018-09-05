//
//  AudioPlayerController.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 24/08/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioPlayerController : UIViewController {
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    var audioPlayer : AVAudioPlayer?
    
    var audioURL : URL
    
    var recordedAudioURL: URL!
    
    var audioFile: AVAudioFile!
    
    var audioEngine: AVAudioEngine!
    
    var audioPlayerNode: AVAudioPlayerNode!
    
    var stopTimer: Timer!

    var wallpaperImageView = UIImageView.init(image: #imageLiteral(resourceName: "blue-wallpaper-3"), contentMode: .scaleAspectFill, size: nil)

    var titleLabel = UILabel(text: "Select your favorite effect", textColor: .white, font: .normal , numberOfLines: 1)
    
    var snailButton = UIButton(image: #imageLiteral(resourceName: "Slow"), text: nil)
    
    var rabbitButton = UIButton(image: #imageLiteral(resourceName: "Fast"), text: nil)
    
    var chipmunkButton = UIButton(image: #imageLiteral(resourceName: "HighPitch"), text: nil)

    var darthVaderButton = UIButton(image: #imageLiteral(resourceName: "LowPitch"), text: nil)

    var echoButton = UIButton(image: #imageLiteral(resourceName: "Echo"), text: nil)

    var reverbButton = UIButton(image: #imageLiteral(resourceName: "Reverb"), text: nil)
    
    var pauseButton = UIButton(image: #imageLiteral(resourceName: "Pause"))
    
    let entireStack = UIStackView(axis: .vertical, spacing: 0, distribution: .fillEqually)

    var recordNewSoundButton = UIButton(image: nil, text: "RECORD A NEW SOUND", font: .normalBold)
    
    var readyToPlay = false
    
    init(audioURL: URL) {
        self.audioURL = audioURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupNavigation()
        setupButtonsTag()
        setupButtonsContentMode()
        setupAudio()
        createBinds()
        setupLayout()
}

    func setupNavigation() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Pitch Perfect"
    }
    
    func setupAudio() {
        do {
            audioFile = try AVAudioFile(forReading: audioURL)
        } catch {
            showAlert("An error ocurred", message: String(describing: error))
        }
    }
    
    func setupButtonsTag() {
        
        snailButton.tag = 0
        rabbitButton.tag = 1
        chipmunkButton.tag = 2
        darthVaderButton.tag = 3
        echoButton.tag = 4
        reverbButton.tag = 5
        
    }
    
    func setupButtonsContentMode() {
        [snailButton,rabbitButton,chipmunkButton,darthVaderButton,echoButton,reverbButton].forEach { $0.imageView?.contentMode = .scaleAspectFit}
    }
    
    func createBinds() {
        recordNewSoundButton.addTarget(self, action: #selector(goToFirstScreen), for: .touchUpInside)
        
        [snailButton,rabbitButton,chipmunkButton,darthVaderButton,echoButton,reverbButton,pauseButton].forEach { $0.addTarget(self, action: #selector(changeAudioStatus), for: .touchUpInside)}
        
        pauseButton.addTarget(self, action: #selector(stopAudio), for: .touchUpInside)
    }
    
    @objc func stopAudio() {
        if let audioPlayerNode = audioPlayerNode {
            audioPlayerNode.stop()
        }
        
        if let stopTimer = stopTimer {
            stopTimer.invalidate()
        }
        
        if let audioEngine = audioEngine {
            audioEngine.stop()
            audioEngine.reset()
        }
        readyToPlay = false
        animateView(status: readyToPlay)
    }
    
    @objc func goToFirstScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func changeAudioStatus(sender:UIButton) {
        
        readyToPlay = !readyToPlay
        
        animateView(status: readyToPlay)
        
        if readyToPlay == true {
            switch ButtonType(rawValue: sender.tag)! {
            case .slow:
                playSound(type: .slow)
            case .fast:
                playSound(type: .fast)
            case .vader:
                playSound(type: .vader)
            case .chipmunk:
                playSound(type: .chipmunk)
            case .reverb:
                playSound(type: .reverb)
            case .echo:
                playSound(type: .echo)
            }
        }
    }
    
    func animateView(status: Bool) {
        
        [entireStack,pauseButton].forEach {$0.alpha = 0}
        
         UIView.animate(withDuration: 0.5, animations: {
            
            self.pauseButton.isHidden = !status
            self.entireStack.isHidden = status
            
            [self.entireStack,self.pauseButton].forEach {$0.alpha = 1}
    })
}
}
