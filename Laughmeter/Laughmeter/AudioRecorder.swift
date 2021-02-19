//
//  AudioRecorder.swift
//  Laughmeter
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: ObservableObject {
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var recording = false {
            didSet {
                objectWillChange.send(self)
            }
        }
}
