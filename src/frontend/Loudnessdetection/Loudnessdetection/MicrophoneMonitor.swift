import Foundation
import AVFoundation

class MicrophoneMonitor: ObservableObject {
    
    private var audioRecorder: AVAudioRecorder
    private var timer: Timer?
    
    @Published public var soundSamples: Float
    
    init() {
        self.soundSamples = Float(0.0)
        
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("The Laughmeter only works if you grant record permissions!")
                }
            }
        }
        
        let url = URL(fileURLWithPath: "/dev/null", isDirectory: true)
        let recorderSettings: [String:Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            
            startMonitoring()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func startMonitoring() {
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            self.audioRecorder.updateMeters()
            self.soundSamples = self.audioRecorder.averagePower(forChannel: 0)
        })
    }
    
    public func stopMonitoring() {
        audioRecorder.stop()
        timer?.invalidate()
    }
    
    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
}
