//
//  ViewController.swift
//  LaughmeterStoryboard
//
//  Created by Simon Koll on 19.05.21.
//

import Foundation
import UIKit
import AVFoundation
import CoreAudio

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    var recorder: AVAudioRecorder!
    var levelTimer = Timer()
    var isLoudEnough: Float = 0.0
    var progress: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(progressView)
        progressView.frame = CGRect(x: 10, y: 100, width: view.frame.width-20, height: 20)
        
        let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        let url = documents.appendingPathComponent("record.caf")

        let recordSettings: [String: Any] = [
            AVFormatIDKey:              kAudioFormatAppleIMA4,
            AVSampleRateKey:            44100.0,
            AVNumberOfChannelsKey:      2,
            AVEncoderBitRateKey:        12800,
            AVLinearPCMBitDepthKey:     16,
            AVEncoderAudioQualityKey:   AVAudioQuality.max.rawValue
        ]

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession.setActive(true)
            try recorder = AVAudioRecorder(url:url, settings: recordSettings)

        } catch {
            return
        }

        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        recorder.record()

        levelTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(levelTimerCallback), userInfo: nil, repeats: true)

    }
    @objc func levelTimerCallback() {
        recorder.updateMeters()

        let level = recorder.averagePower(forChannel: 0)+80
        self.isLoudEnough = self.isLoudEnough + level
        self.progress = self.isLoudEnough/50000
        print("Level:")
        print(level)
        print("Gesamt:")
        print(self.isLoudEnough)
        print("Value von Progressbar:")
        print(self.progress)
        self.progressView.setProgress(self.progress, animated: true)
        if(self.isLoudEnough >= 50000){
            print("ENDE")
            exit(0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
