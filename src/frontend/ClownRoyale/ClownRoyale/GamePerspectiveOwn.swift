//
//  GamePerspectiveOwn.swift
//  ClownRoyale
//
//  Created by Matthias Riener on 22.03.21.
//

import SwiftUI

struct GamePerspectiveOwn: View {
    var body: some View {
        VStack(
        ) {
            GamePerspectiveTop()
            GamePerspectiveContentMain()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("ClownYellowBackground")).ignoresSafeArea()
        
   
    }
}

struct GamePerspectiveContentMain: View {
    var body: some View {
        VStack() {
            ZStack(alignment: .top) {
               
                
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .frame(width: UIScreen.screenWidth / 10 * 8.5, height: UIScreen.screenWidth / 10 * 8.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Image("jan")
                            .resizable()
                            .cornerRadius(35)
                            .ignoresSafeArea()
                            .frame(width: UIScreen.screenWidth / 10 * 8.5 - 10, height: UIScreen.screenWidth / 10 * 8.5 - 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    )
                
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("ClownYellow"))
                    .frame(width: UIScreen.screenWidth / 3 * 2, height: 70, alignment: .center)
                    .overlay(
                        HStack() {
                            Text("Category:")
                                .font(.system(size: 18))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding()
                                .foregroundColor(.white)
                            Text("Random")
                                .font(.system(size: 25))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding()
                                .foregroundColor(.white)
                        }
                       
                    ).padding(.top, -35)
            }.padding(.top, 59)
           
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0).padding(.top, 20)
        
    }
}

struct GamePerspectiveTop: View {
    var body: some View {
        HStack(spacing: 0) {
            // width 25%
            VStack() {
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color.red)
                    .frame(width: 60, height: 60, alignment: .center)
                    .overlay(
                        Text("38")
                            .font(.system(size: 21))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding()
                            .foregroundColor(.white)
                    )
                
                
                    
                           

            }.frame(
                width: UIScreen.screenWidth / 10 * 2.5
            )
            
            // width 50%
            VStack() {
                Text("6/8")
                    .font(.system(size: 21))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Text("Franzi68")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }.frame(
                width: UIScreen.screenWidth / 10 * 5
            )
            
            // width 25%
            VStack() {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.white)
                    .frame(width: 8, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 15)
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.white)
                    .frame(width: 8, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 15)
                
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.white)
                    .frame(width: 8, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 15)
                
                
          }.frame(
                width: UIScreen.screenWidth / 10 * 2.5 - 15,
            alignment: .trailing
            )
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 110, alignment: .bottom)
        .padding(.bottom, 10)
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [Color("ClownYellowHell"),
                             Color("ClownYellow")]),
                startPoint: .leading,
                endPoint: .trailing
            )
        
        .edgesIgnoringSafeArea(.top))

    }
}

struct GamePerspectiveOwn_Previews: PreviewProvider {
    static var previews: some View {
        GamePerspectiveOwn()
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
