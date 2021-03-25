//
//  GamePerspectiveOwnView.swift
//  ClownRoyale
//
//  Created by Matthias Riener on 22.03.21.
//

import SwiftUI

struct GamePerspectiveOwnView: View {
    var body: some View {
        NavigationView {
            VStack(
            ) {
                GamePerspectiveTopContainer()
                GamePerspectiveMainContainer()
                GamePerspectiveBottomContainer()

        
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color("ClownYellowBackground")).ignoresSafeArea().hiddenNavigationBarStyle()
        }.hiddenNavigationBarStyle()
        
        
   
    }
}

struct GamePerspectiveOwnView_Previews: PreviewProvider {
    static var previews: some View {
        GamePerspectiveOwnView()
    }
}

struct GamePerspectiveMainContainer: View {
        var body: some View {
           VStack() {
            
                  Text("Tell your joke")
                    .font(.system(size: 22))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("ClownYellow"))
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
                          
                       )
            HStack() {
                Text("Votes")
                    .font(.system(size: 22))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("ClownYellow"))
            }.frame(width: UIScreen.screenWidth / 10 * 8.5, height: 30, alignment: .trailing)
            
            ZStack() {
                PlayerRoom()
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("ClownYellowBackground"))
                    .frame(width: UIScreen.screenWidth / 10 * 4.5, height: UIScreen.screenWidth / 10 * 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Image("jan")
                            .resizable()
                            .cornerRadius(35)
                            .ignoresSafeArea()
                            .frame(width: UIScreen.screenWidth / 10 * 4.5 - 20, height: UIScreen.screenWidth / 10 * 6 - 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    )
                    .padding(.trailing, -UIScreen.screenWidth / 10 * 6.5)
                    .padding(.bottom, -UIScreen.screenHeight)
                
            }
            .frame(width: UIScreen.screenWidth / 10 * 9, height: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
               
           }
           .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0).padding(.top, 20)
           
       
    }
}

struct GamePerspectiveBottomContainer: View {
    var body: some View {
        VStack() {
            NavigationLink(destination: RankingUIView()) {
                Text("Finished")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 90
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
            
        }.frame(width: .infinity, height: 120, alignment: .bottom)
        
    }
}

struct GamePerspectiveTopContainer: View {
    var body: some View {
        HStack(spacing: 0) {
            // width 25%
            VStack() {
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color.blue)
                    .frame(width: 55, height: 55, alignment: .center)
                    .overlay(
                        Text("38")
                            .font(.system(size: 17))
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
                Text("Your turn")
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
                    .frame(width: 7.5, height: 7.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 12)
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.white)
                    .frame(width: 7.5, height: 7.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 12)
                
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.white)
                    .frame(width: 7.5, height: 7.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 12)
                
                
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
