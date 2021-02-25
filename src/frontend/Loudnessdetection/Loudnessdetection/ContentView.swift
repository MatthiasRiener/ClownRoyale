import Foundation
import SwiftUI

var total: Float = 0.0

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ProgressBar: View {
    var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .leading){
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(hex:"#ffB199"))
                
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(hex: "#FFB400"))
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

