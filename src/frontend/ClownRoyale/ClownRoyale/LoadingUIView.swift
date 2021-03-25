//
//  LoadingUIView.swift
//  ClownRoyale
//
//  Created by Jan Donnerbauer on 10.03.21.
//

import SwiftUI

struct LoadingUIView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Image("bus")
                    .resizable()
                    .aspectRatio(contentMode:.fill)
                    .offset(x: 120, y: 0)
                    .ignoresSafeArea()
                
                NavigationLink(destination: MenuSwiftUIView()) {
                    Text("ClownRoyale")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                    .frame(
                        maxWidth: .infinity
                    )
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [Color("ClownYellow"),
                                         Color("ClownYellowHell")]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    .edgesIgnoringSafeArea(.bottom))
                }
                
            }
        }.hiddenNavigationBarStyle()
        
    }
}

struct LoadingUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingUIView()
    }
}
