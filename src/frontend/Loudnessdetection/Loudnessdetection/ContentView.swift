//
//  ContentView.swift
//  Loudnessdetection
//

import Foundation
import SwiftUI
let numberOfSamples: Int = 10

/*struct BarView: View {
   // 1
    var value: CGFloat

    var body: some View {
        ZStack {
           // 2
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                // 3
                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples), height: value)
        }
    }
}*/

struct ProgressBar: View {
    var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .leading){
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemBlue))
            }.cornerRadius(45.0)
        }
    }
}

struct ContentView: View {
    @State var progressValue: Float = 0.0
    // 1
    @ObservedObject private var mic = MicrophoneMonitor(/*numberOfSamples: numberOfSamples*/)
    
    // 2
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        print("Value: \(level)")
        
        return CGFloat(level / 100) // scaled to max at 300 (our height of our bar)
    }
        
    var body: some View {
        /*VStack {
             // 3
            HStack(spacing: 4) {
                 // 4
                /*ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: self.normalizeSoundLevel(level: level))
                }*/
                BarView(value: self.normalizeSoundLevel(level: mic.soundSamples))
            }
        }*/
        
        VStack {
            ProgressBar(value: Float(self.normalizeSoundLevel(level: mic.soundSamples))).frame(height: 20)
            Spacer()
        }.padding()
    }
}

