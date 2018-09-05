//
//  RecordingAudioViewController.swift
//  Pitch Perfect
//
//  Created by Matheus Dutra on 29/07/2018.
//  Copyright © 2018 Matheus Dutra. All rights reserved.
//

import UIKit
import AVFoundation

enum RecordingStatus {
    case success
    case fail
    case readyToRecord
    case recording
}

class RecordingAudioViewController: UIViewController {
    
    var recordingSession: AVAudioSession!

    var audioRecorder : AVAudioRecorder!
    
    var audioPath : URL?
    
    var wallpaperImageView = UIImageView.init(image: #imageLiteral(resourceName: "blue-wallpaper-3"), contentMode: .scaleAspectFill, size: nil)
    
    var titleLabel = UILabel.init(text: "Pitch Perfect", textColor: .clear, font: .normalBold, numberOfLines: 1)
    
    var recordingLabel = UILabel.init(text: "Tap to start recording....", textColor: .white, font: .normal, numberOfLines: 1)
    
    var recordButton = UIButton.init(image: #imageLiteral(resourceName: "Record"))
    
    var recordTimer = Timer()
    
    var counter : Int = 0 {
        didSet {
            recordingLabel.text =  counter.timeStamp(intSeconds: counter)
            recordingLabel.centered()
        }
    }

    var recordTime = UILabel(text: "", textColor: .white, font: .normal, numberOfLines: 1)
    
    var recordingStatus : RecordingStatus = .readyToRecord
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        createBinds()
        setupNavigation()
        setupUpRecorder()
    
        }

    func createBinds() {
        recordButton.addTarget(self, action: #selector(changeRecordStatus), for: .touchUpInside)
    }
    
    func setupNavigation() {
        
        self.title = "Pitch Perfect"
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        let multipleAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        
        navigationController?.navigationBar.largeTitleTextAttributes = multipleAttributes
        
    }
    
    func setupUpRecorder() {
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.setupLayout()
                    } else {
                        self.showAlert("Ops", message: "An error ocurred")
                    }
                }
            }
        } catch {
            self.showAlert("Ops", message: "Fail to record")
        }
    }
    
    @objc func changeRecordStatus() {
        
        switch recordingStatus {
            
        case .readyToRecord, .fail:
            startRecording()
            
        case .recording, .success:
            stopRecording()
        }
        
         animateView(status: recordingStatus)
        
    }
    
    @objc func timerAction() {
        counter += 1
    }
    
    func startRecording() {
        
        // start the timer
        recordTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        audioPath = getDocumentsDirectory().appendingPathComponent("recordedAudio.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            guard let audioPath = audioPath else { return }
            audioRecorder = try AVAudioRecorder(url: audioPath, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordingStatus = .recording
        } catch {
            recordingStatus = .fail
            finishRecording()
        }
    }

    func stopRecording() {
        
        recordTimer.invalidate()
        counter = 0
        
        if audioRecorder == nil {
            recordingStatus = .fail
        } else {
            recordingStatus = .success
            finishRecording()
        }
    }
    
    func finishRecording() {
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if recordingStatus == .success {
            
        guard let audioPath = audioPath else { return }
        
        recordingStatus = .readyToRecord
            
        self.navigationController?.pushViewController(AudioPlayerController(audioURL: audioPath), animated: true)
            
        }
    }
    
    func animateView(status: RecordingStatus) {
        
        [self.recordingLabel,self.recordButton].forEach { $0.alpha = 0 }

        UIView.animate(withDuration: 0.5, animations: {

         
            [self.recordingLabel,self.recordButton].forEach { $0.alpha = 1 }
            
            switch status {
                
            case .fail:
            self.recordButton.setImage(#imageLiteral(resourceName: "Record"), for: .normal)
            self.recordingLabel.text = "Fail to record audio, please, try again."
                
            case .readyToRecord:
            self.recordButton.setImage(#imageLiteral(resourceName: "Record"), for: .normal)
            self.recordingLabel.text =  "Tap to start recording...."
            
            case .recording:
            self.recordButton.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
            self.recordingLabel.text = "Recording audio...."
                
            case .success:
            self.recordingLabel.text = "Processing your audio :)"

            }
        })
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension RecordingAudioViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            recordingStatus = .fail
            animateView(status: recordingStatus)
            finishRecording()
        }
    }

}

