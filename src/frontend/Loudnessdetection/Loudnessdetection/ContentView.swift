import Foundation
import SwiftUI

var total: Float = 0.0

struct ProgressBar: View {
    var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .leading){
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
            }.cornerRadius(45.0)
        }
    }
}

struct ContentView: View {
    @ObservedObject private var mic = MicrophoneMonitor()
    
    private func normalizeSoundLevel(level: Float) -> Float {
        let level = max(0.2, level + 50) / 2
                
        if total < 10000 {
            total = total + level
            print("Total: \(total)")
        } else {
            print("Congrats")
            mic.stopMonitoring()
        }
        
        return total / 10000
    }
        
    var body: some View {
        VStack {
            ProgressBar(value: self.normalizeSoundLevel(level: mic.soundSamples)).frame(height: 20)
            Spacer()
        }.padding()
    }
}

