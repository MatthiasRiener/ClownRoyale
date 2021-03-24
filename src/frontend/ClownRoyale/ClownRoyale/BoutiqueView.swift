//
//  BoutiqueView.swift
//  ClownRoyale
//
//  Created by Lukas Friesenecker on 24.03.21.
//

import SwiftUI

struct BoutiqueTop: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        
                    }.frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenHeight * 0.1, alignment: .center)
                    
                    VStack {
                        Text("Clown Boutique")
                            .foregroundColor(Color("ClownGray"))
                            .font(.system(size: 26))
                            .bold()
                    }
                    .frame(width: UIScreen.screenWidth * 0.6, height: UIScreen.screenHeight * 0.1, alignment: .center)
                    
                    VStack {
                        Text("1536")
                            .foregroundColor(Color("ClownYellow"))
                            .font(.system(size: 20))
                            .bold()
                    }
                    .frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenHeight * 0.1, alignment: .center)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.1, alignment: .center)
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.14, alignment: .bottom)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.8), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1.0)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.15, alignment: .top)
        .background(Color.white)
    }
}

struct BoutiqueMiddle: View {
    var body: some View {
        VStack {
            
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.5, alignment: .top)
        .background(Color.white)
    }
}

struct BoutiqueBottom: View {
    var body: some View {
        VStack {
            
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.35, alignment: .top)
        .background(Color.white)

    }
}

struct BoutiqueView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BoutiqueTop()
            BoutiqueMiddle()
            BoutiqueBottom()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("ClownYellowBackground")).ignoresSafeArea()
    }
}
