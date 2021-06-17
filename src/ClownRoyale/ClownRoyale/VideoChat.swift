import UIKit

import TwilioVideo

class VideoChat : UIViewController{
    
    //Shared-Instance
    static let videoSharedInstance = VideoChat()
    
    var accessToken = "TWILIO_ACCESS_TOKEN"
    
    // URL für Token
    var tokenUrl = "http://172.20.10.3:5000"
    
    // Video SDK components
    var room: Room?
    var camera: CameraSource?
    var localVideoTrack: LocalVideoTrack?
    var localAudioTrack: LocalAudioTrack?
    var remoteParticipant: RemoteParticipant?
    var remoteView : VideoView?
    
    deinit {
        // We are done with camera
        if let camera = self.camera {
            camera.stopCapture()
            self.camera = nil
        }
    }
    
    func connect(){
        // Configure access token either from server or manually.
        // If the default wasn't changed, try fetching from server. (Sicherheit)
        print("CONNECT")
        if (accessToken == "TWILIO_ACCESS_TOKEN") {
            do {
                try TokenUtils.sendData(completionHandler: {data in
                    self.accessToken = data
                })
            } catch {
                let message = "Failed to fetch access token"
                logMessage(messageText: message)
                return
            }
        }
        
        // Prepare local media which we will share with Room Participants.
        self.prepareLocalMedia()
        
        // Preparing the connect options with the access token that we fetched (or hardcoded).
        let connectOptions = ConnectOptions(token: accessToken) { (builder) in
            
            // Use the local media that we prepared earlier.
            builder.audioTracks = self.localAudioTrack != nil ? [self.localAudioTrack!] : [LocalAudioTrack]()
            builder.videoTracks = self.localVideoTrack != nil ? [self.localVideoTrack!] : [LocalVideoTrack]()
            
            // Use the preferred audio codec
            if let preferredAudioCodec = Settings.shared.audioCodec {
                builder.preferredAudioCodecs = [preferredAudioCodec]
            }
            
            // Use the preferred video codec
            if let preferredVideoCodec = Settings.shared.videoCodec {
                builder.preferredVideoCodecs = [preferredVideoCodec]
            }
            
            // Use the preferred encoding parameters
            if let encodingParameters = Settings.shared.getEncodingParameters() {
                builder.encodingParameters = encodingParameters
            }
            
            // Use the preferred signaling region
            if let signalingRegion = Settings.shared.signalingRegion {
                builder.region = signalingRegion
            }
            
            // The name of the Room where the Client will attempt to connect to
            builder.roomName = SocketIOManager.sharedInstance.roomID!
        }
        
        // Connect to the Room using the options we provided.
        room = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
        
        logMessage(messageText: "Attempting to connect to room \(String(describing: "\(SocketIOManager.sharedInstance.roomID)"))")
        
        //Clown, der zurzeit den Witz erzählt, rendern
        self.changeClown()
    }
    
    /*
     Clown, der zurzeit den Witz erzählt, wird gerendert
     */
    func changeClown(){
        print("CLOWN RENDER")
        print(self.room?.remoteParticipants)
        
        if(self.room?.remoteParticipants.count ?? 0 > 0){
            print("CLOWN FOUND")
            let videoPublications = self.remoteParticipant?.remoteVideoTracks
            
            //Zuvor gerenderter Clown muss entfernt werden (Twilio Eigenheit. Warum? ka)
            if(videoPublications != nil){
                for publication in videoPublications! {
                    if let subscribedVideoTrack = publication.remoteTrack,
                       publication.isTrackSubscribed {
                        print("gg")
                        if(self.remoteView != nil) {
                            subscribedVideoTrack.removeRenderer(self.remoteView as! VideoRenderer)
                        }
                    }
                }
            }
            
            //User ID des aktuell erzählenden Clowns
            let teller = SocketIOManager.sharedInstance.currentTeller.value(forKey: "teller") as! NSDictionary
            let userID = teller.value(forKey: "u_id") as! String
            print("USERID: \(userID)")
            
            //Teilnehmer in Videochat (exklusive mir selbst)
            let remainingParticipants = self.room?.remoteParticipants
            print("PAR: \(String(describing: remainingParticipants))")
            
            //Teilnehmer werden durchgegangen --> Suche nach aktuellem Erzähler
            for participant in self.room?.remoteParticipants as! [RemoteParticipant] {
                
                print("\(participant.identity) IDENTITY")
                print("\(userID) IDENTITY")
                
                //Erzähler gefunden
                if participant.identity == userID {
                    print("ERZÄHLER: \(participant)")
                    print("ERZÄHLER REMOTE VIEW: \(String(describing: self.remoteView))")
                    let dummy = self.renderRemoteParticipant(participant: (participant))
                    print("SUCCESS: \(dummy)")
                }
            }
            self.remoteView?.reloadInputViews()
        }
        
    }
    
    /*
     Mikrofon ein- oder ausschalten
     */
    func toggleMic(status : String) {
        if (self.localAudioTrack != nil) {
            if(status == "mute"){
                self.localAudioTrack?.isEnabled = false
                print("muted")
            }else {
                self.localAudioTrack?.isEnabled = true
                print("unmuted")
            }
        }
    }
    
    /*
     Disconnect von Videochat
     */
    func disconnect(){
        self.room!.disconnect()
        
        //Aufräumen
        cleanupRemoteParticipant()
        logMessage(messageText: "Attempting to disconnect from room \(room!.name)")
    }
    
    
    func setupRemoteVideoView(){
        print("RESET: \(String(describing: self.remoteView))")
    }
    
    /*
     eigenen Videostream vorbereiten
     */
    func startPreview() {
        //Simulator hat keine Kamera --> weg damit
        if PlatformUtils.isSimulator {
            return
        }
        
        //Kameras
        let frontCamera = CameraSource.captureDevice(position: .front)
        let backCamera = CameraSource.captureDevice(position: .back)
        
        if (frontCamera != nil || backCamera != nil) {
            
            let options = CameraSourceOptions { (builder) in
                if #available(iOS 13.0, *) {
                    // Track UIWindowScene events for the key window's scene.
                    // The example app disables multi-window support in the .plist (see UIApplicationSceneManifestKey).
                    //builder.orientationTracker = UserInterfaceTracker(scene: UIApplication.shared.keyWindow!.windowScene!)
                }
            }
            
            // Preview our local camera track in the local video preview view.
            camera = CameraSource(options: options, delegate: self)
            localVideoTrack = LocalVideoTrack(source: camera!, enabled: true, name: "Camera")
            
            
            camera!.startCapture(device: frontCamera != nil ? frontCamera! : backCamera!) { (captureDevice, videoFormat, error) in
                if let error = error {
                    self.logMessage(messageText: "Capture failed with error.\ncode = \((error as NSError).code) error = \(error.localizedDescription)")
                } else {
                    /*
                     self.previewView.shouldMirror = (captureDevice.position == .front)
                     */
                }
            }
        }
        else {
            self.logMessage(messageText:"No front or back capture device found!")
        }
    }
    
    /*
     Kamera flippen
     zurzeit nicht in Verwendung!!!!
     */
    @objc func flipCamera() {
        var newDevice: AVCaptureDevice?
        
        if let camera = self.camera, let captureDevice = camera.device {
            if captureDevice.position == .front {
                newDevice = CameraSource.captureDevice(position: .back)
            } else {
                newDevice = CameraSource.captureDevice(position: .front)
            }
            
            if let newDevice = newDevice {
                camera.selectCaptureDevice(newDevice) { (captureDevice, videoFormat, error) in
                    if let error = error {
                        self.logMessage(messageText: "Error selecting capture device.\ncode = \((error as NSError).code) error = \(error.localizedDescription)")
                    } else {
                        /*
                         self.previewView.shouldMirror = (captureDevice.position == .front)
                         */
                    }
                }
            }
        }
    }
    
    /*
     Lokale Medien (Audio + Video) vorbereiten
     */
    func prepareLocalMedia() {
        // Create an audio track.
        if (localAudioTrack == nil) {
            localAudioTrack = LocalAudioTrack(options: nil, enabled: true, name: "Microphone")
            
            if (localAudioTrack == nil) {
                logMessage(messageText: "Failed to create audio track")
            }
        }
        
        // Create a video track which captures from the camera.
        if (localVideoTrack == nil) {
            self.startPreview()
        }
    }
    
    /*
     Logger
     */
    func logMessage(messageText: String) {
        NSLog(messageText)
        print(messageText)
    }
    
    /*
     rendert einen Videochatteilnehmer
     */
    func renderRemoteParticipant(participant : RemoteParticipant) -> Bool {
        
        // This example renders the first subscribed RemoteVideoTrack from the RemoteParticipant (einfacher)
        // Teilnehmer kann mehrere Videostreams haben
        let videoPublications = participant.remoteVideoTracks
        print("TRACKS: \(participant.remoteVideoTracks)")
        
        for publication in videoPublications {
            if let subscribedVideoTrack = publication.remoteTrack,
               publication.isTrackSubscribed {
                setupRemoteVideoView()
                
                //Renderer hinzufügen
                if(self.remoteView != nil){
                    subscribedVideoTrack.addRenderer(self.remoteView!)
                }
                //Aktuell gerenderter User ändern
                self.remoteParticipant = participant
                return true
            }
        }
        return false
    }
    
    /*
     nicht in Verwendung
     */
    func renderRemoteParticipants(participants : Array<RemoteParticipant>) {
        for participant in participants {
            // Find the first renderable track.
            print("\(participant.remoteVideoTracks.count) test")
            if participant.remoteVideoTracks.count > 0,
               renderRemoteParticipant(participant: participant) {
                break
            }
        }
    }
    
    /*
     nach Runde aufräumen
     */
    func cleanupRemoteParticipant() {
        if self.remoteParticipant != nil {
            self.remoteView?.removeFromSuperview()
            self.remoteView = nil
            self.remoteParticipant = nil
        }
    }
}

// MARK:- UITextFieldDelegate
extension VideoChat : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.connect()
        return true
    }
}

// MARK:- RoomDelegate
extension VideoChat : RoomDelegate {
    func roomDidConnect(room: Room) {
        logMessage(messageText: "Connected to room \(room.name) as \(room.localParticipant?.identity ?? "")")
        
        // This example only renders 1 RemoteVideoTrack at a time. Listen for all events to decide which track to render.
        print(room.remoteParticipants)
        self.changeClown()
        
        for remoteParticipant in room.remoteParticipants {
            remoteParticipant.delegate = self
        }
        
    }
    
    func roomDidDisconnect(room: Room, error: Error?) {
        logMessage(messageText: "Disconnected from room \(room.name), error = \(String(describing: error))")
        
        self.cleanupRemoteParticipant()
        self.room = nil
        
        //self.showRoomUI(inRoom: false)
    }
    
    func roomDidFailToConnect(room: Room, error: Error) {
        logMessage(messageText: "Failed to connect to room with error = \(String(describing: error))")
        print(self.accessToken)
        self.room = nil
        
        //self.showRoomUI(inRoom: false)
    }
    
    func roomIsReconnecting(room: Room, error: Error) {
        logMessage(messageText: "Reconnecting to room \(room.name), error = \(String(describing: error))")
    }
    
    func roomDidReconnect(room: Room) {
        logMessage(messageText: "Reconnected to room \(room.name)")
    }
    
    func participantDidConnect(room: Room, participant: RemoteParticipant) {
        // Listen for events from all Participants to decide which RemoteVideoTrack to render.
        participant.delegate = self
        
        logMessage(messageText: "Participant \(participant.identity) connected with \(participant.remoteAudioTracks.count) audio and \(participant.remoteVideoTracks.count) video tracks")
    }
    
    func participantDidDisconnect(room: Room, participant: RemoteParticipant) {
        logMessage(messageText: "Room \(room.name), Participant \(participant.identity) disconnected")
        
        // Nothing to do in this example. Subscription events are used to add/remove renderers.
    }
}

// MARK:- RemoteParticipantDelegate
extension VideoChat : RemoteParticipantDelegate {
    
    func remoteParticipantDidPublishVideoTrack(participant: RemoteParticipant, publication: RemoteVideoTrackPublication) {
        // Remote Participant has offered to share the video Track.
        print("hello")
        logMessage(messageText: "Participant \(participant.identity) published \(publication.trackName) video track")
    }
    
    func remoteParticipantDidUnpublishVideoTrack(participant: RemoteParticipant, publication: RemoteVideoTrackPublication) {
        // Remote Participant has stopped sharing the video Track.
        
        logMessage(messageText: "Participant \(participant.identity) unpublished \(publication.trackName) video track")
    }
    
    func remoteParticipantDidPublishAudioTrack(participant: RemoteParticipant, publication: RemoteAudioTrackPublication) {
        // Remote Participant has offered to share the audio Track.
        
        logMessage(messageText: "Participant \(participant.identity) published \(publication.trackName) audio track")
    }
    
    func remoteParticipantDidUnpublishAudioTrack(participant: RemoteParticipant, publication: RemoteAudioTrackPublication) {
        // Remote Participant has stopped sharing the audio Track.
        
        logMessage(messageText: "Participant \(participant.identity) unpublished \(publication.trackName) audio track")
    }
    
    func didSubscribeToVideoTrack(videoTrack: RemoteVideoTrack, publication: RemoteVideoTrackPublication, participant: RemoteParticipant) {
        // The LocalParticipant is subscribed to the RemoteParticipant's video Track. Frames will begin to arrive now.
        
        logMessage(messageText: "Subscribed to \(publication.trackName) video track for Participant \(participant.identity)")
        
        self.changeClown()
    }
    
    func didUnsubscribeFromVideoTrack(videoTrack: RemoteVideoTrack, publication: RemoteVideoTrackPublication, participant: RemoteParticipant) {
        // We are unsubscribed from the remote Participant's video Track. We will no longer receive the
        // remote Participant's video.
        
        logMessage(messageText: "Unsubscribed from \(publication.trackName) video track for Participant \(participant.identity)")
        
        if self.remoteParticipant == participant {
            cleanupRemoteParticipant()
            
            // Find another Participant video to render, if possible.
            if var remainingParticipants = room?.remoteParticipants,
               let index = remainingParticipants.firstIndex(of: participant) {
                remainingParticipants.remove(at: index)
                print("NO NO ZONE")
                renderRemoteParticipants(participants: remainingParticipants)
            }
        }
    }
    
    func didSubscribeToAudioTrack(audioTrack: RemoteAudioTrack, publication: RemoteAudioTrackPublication, participant: RemoteParticipant) {
        // We are subscribed to the remote Participant's audio Track. We will start receiving the
        // remote Participant's audio now.
        
        logMessage(messageText: "Subscribed to \(publication.trackName) audio track for Participant \(participant.identity)")
        self.changeClown()
    }
    
    func didUnsubscribeFromAudioTrack(audioTrack: RemoteAudioTrack, publication: RemoteAudioTrackPublication, participant: RemoteParticipant) {
        // We are unsubscribed from the remote Participant's audio Track. We will no longer receive the
        // remote Participant's audio.
        
        logMessage(messageText: "Unsubscribed from \(publication.trackName) audio track for Participant \(participant.identity)")
    }
    
    func remoteParticipantDidEnableVideoTrack(participant: RemoteParticipant, publication: RemoteVideoTrackPublication) {
        logMessage(messageText: "Participant \(participant.identity) enabled \(publication.trackName) video track")
        self.changeClown()
    }
    
    func remoteParticipantDidDisableVideoTrack(participant: RemoteParticipant, publication: RemoteVideoTrackPublication) {
        logMessage(messageText: "Participant \(participant.identity) disabled \(publication.trackName) video track")
        self.changeClown()
    }
    
    func remoteParticipantDidEnableAudioTrack(participant: RemoteParticipant, publication: RemoteAudioTrackPublication) {
        logMessage(messageText: "Participant \(participant.identity) enabled \(publication.trackName) audio track")
        self.changeClown()
    }
    
    func remoteParticipantDidDisableAudioTrack(participant: RemoteParticipant, publication: RemoteAudioTrackPublication) {
        logMessage(messageText: "Participant \(participant.identity) disabled \(publication.trackName) audio track")
        self.changeClown()
    }
    
    func didFailToSubscribeToAudioTrack(publication: RemoteAudioTrackPublication, error: Error, participant: RemoteParticipant) {
        logMessage(messageText: "FailedToSubscribe \(publication.trackName) audio track, error = \(String(describing: error))")
    }
    
    func didFailToSubscribeToVideoTrack(publication: RemoteVideoTrackPublication, error: Error, participant: RemoteParticipant) {
        logMessage(messageText: "FailedToSubscribe \(publication.trackName) video track, error = \(String(describing: error))")
    }
}

// MARK:- VideoViewDelegate
extension ViewController : VideoViewDelegate {
    func videoViewDimensionsDidChange(view: VideoView, dimensions: CMVideoDimensions) {
        self.view.setNeedsLayout()
    }
}

// MARK:- CameraSourceDelegate
extension VideoChat : CameraSourceDelegate {
    func cameraSourceDidFail(source: CameraSource, error: Error) {
        logMessage(messageText: "Camera source failed with error: \(error.localizedDescription)")
    }
}
