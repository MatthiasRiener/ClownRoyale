//
//  VideoChat.swift
//  ClownRoyale
//
//  Created by Jan Donnerbauer on 01.04.21.
//

import Foundation
import SwiftUI
import Combine

import TwilioVideo

class VideoChatController {
    // MARK:- View Controller Members
    
    // Configure access token manually for testing, if desired! Create one manually in the console
    // at https://www.twilio.com/console/video/runtime/testing-tools
    var accessToken = "TWILIO_ACCESS_TOKEN"
  
    // Configure remote URL to fetch token from
    var tokenUrl = "http://192.168.0.8:3000/accessToken"
    
    // Video SDK components
    var room: Room?
    var camera: CameraSource?
    var localVideoTrack: LocalVideoTrack?
    var localAudioTrack: LocalAudioTrack?
    var remoteParticipant: RemoteParticipant?
    var remoteView: VideoView?
    
    init(){
        
    }
    
    deinit {
        // We are done with camera
        if let camera = self.camera {
            camera.stopCapture()
            self.camera = nil
        }
    }
    
    func hello(){
        print("hellooooo")
    }
}


