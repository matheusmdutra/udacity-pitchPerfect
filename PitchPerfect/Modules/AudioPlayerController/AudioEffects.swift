//
//  PlayAudioEffects.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 26/08/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension AudioPlayerController {
    
    func playSound(type: ButtonType) {
        
        var rate : Double?
        
        audioEngine = AVAudioEngine()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        let pitchNode = AVAudioUnitTimePitch()
        var usePitch = true
        
        switch type {
            
        case .slow:
            rate = 0.5
            pitchNode.rate = 0.5
            
        case .fast:
            pitchNode.rate = 2.0
            
        case .vader:
            pitchNode.pitch = -1000
            
        case .chipmunk:
            pitchNode.pitch = 1000
            
        case .echo:
            usePitch = false
            let echoNode = AVAudioUnitDistortion()
            echoNode.loadFactoryPreset(.multiEcho1)
            audioEngine.attach(echoNode)
            connectAudioNodes([audioPlayerNode, echoNode, audioEngine.outputNode])
            
        case .reverb:
            usePitch = false
            let reverbNode = AVAudioUnitReverb()
            reverbNode.loadFactoryPreset(.cathedral)
            reverbNode.wetDryMix = 30
            audioEngine.attach(reverbNode)
            connectAudioNodes([audioPlayerNode, reverbNode, audioEngine.outputNode])
            
        }
        
        if usePitch {
            audioEngine.attach(pitchNode)
            connectAudioNodes([audioPlayerNode, pitchNode, audioEngine.outputNode])
        }
        
        audioPlayerNode.stop()
        audioPlayerNode.scheduleFile(audioFile, at: nil) {
            
            let delay = self.gettingDelayInSeconds(rate: rate )
            
            self.stopTimer = Timer(timeInterval: delay, target: self, selector: #selector(AudioPlayerController.stopAudio), userInfo: nil, repeats: false)
            RunLoop.main.add(self.stopTimer!, forMode: RunLoopMode.defaultRunLoopMode)
        }
        
        do {
            try audioEngine.start()
        } catch {
            showAlert("An error ocurred", message: String(describing: error))
        }
        audioPlayerNode.play()
    }

    func connectAudioNodes(_ nodes: [AVAudioNode]) {
        for node in 0..<nodes.count-1 {
            audioEngine.connect(nodes[node], to: nodes[node+1], format: audioFile.processingFormat)
        }
    }
    
    func gettingDelayInSeconds(rate: Double? = nil) -> Double {
        
        var delayInSeconds : Double = 0
        
        guard let renderTime = audioPlayerNode.lastRenderTime else { return delayInSeconds }
        guard let timeToPlay = audioPlayerNode.playerTime(forNodeTime: renderTime) else { return delayInSeconds }
        
        delayInSeconds = Double(self.audioFile.length - timeToPlay.sampleTime) / Double(self.audioFile.processingFormat.sampleRate)
        
        if let rate = rate {
            delayInSeconds = delayInSeconds / rate
        }
        return delayInSeconds
    }
    
}
