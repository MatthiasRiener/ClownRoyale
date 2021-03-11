//
//  AppLoadingView.swift
//  ClownRoyale
//
//  Created by Simon Koll on 11.03.21.
//

import Foundation

import SwiftUI
import UIKit

struct AppLoadingView: View {
    @State var gradient = [Color.red, Color.white, Color.red, Color.white, Color.red]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    var body: some View {
      
        ZStack(){
        VStack(alignment: .center, spacing: 0) {
            Group{
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: -250)
                .frame(width: 300, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onTapGesture {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: -200)
                .frame(width: 2000, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onAppear() {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: -150)
                .frame(width: 2000, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onAppear() {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: -100)
                .frame(width: 2000, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onAppear() {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: -50)
                .frame(width: 2000, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onAppear() {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: 0)
                .frame(width: 2000, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onAppear() {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: 50)
                .frame(width: 2000, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onAppear() {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: 100)
                .frame(width: 2000, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onAppear() {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: 150)
                .frame(width: 2000, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onAppear() {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                    .position(x: 1000, y: 200)
                    .frame(width: 2000, height: 50)
                    .rotationEffect(Angle(degrees: 315))
                    .onAppear() {
                        withAnimation (.easeInOut(duration: 3)){
                            self.startPoint = UnitPoint(x: 1, y: -1)
                            self.endPoint = UnitPoint(x: 0, y: 1)
                        }
                }
            }
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .position(x: 1000, y: 250)
                .frame(width: 2000, height: 50)
                .rotationEffect(Angle(degrees: 315))
                .onAppear() {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
        }
            Rectangle()
                .fill(Color.red)
                .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("ClownRoyale").foregroundColor(Color.white)
                
        
    }
}
    
}

struct AppLoadingViewPreviews: PreviewProvider {
    static var previews: some View {
        AppLoadingView()
    }
}
