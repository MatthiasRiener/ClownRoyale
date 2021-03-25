//
//  Profil.swift
//  ClownRoyale
//
//  Created by Lukas Friesenecker on 24.03.21.
//

import SwiftUI

struct ProfileTop: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        
                        NavigationLink(destination: MenuSwiftUIView()) {
                    HomeButton()
                    }.hiddenNavigationBarStyle()
                            
                       
                    }.frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenHeight * 0.1, alignment: .center)
                    
                    HStack {
                        Text("Profile")
                            .foregroundColor(Color.white)
                            .font(.system(size: 30))
                            .bold()
                    }
                    .frame(width: UIScreen.screenWidth * 0.5, height: UIScreen.screenHeight * 0.1, alignment: .center)
                    
                    VStack {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(Color.white)
                            .frame(width: 6, height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 15)
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.white)
                            .frame(width: 6, height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 15)
                        
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .fill(Color.white)
                            .frame(width: 6, height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 15)
                    }
                    .frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenHeight * 0.1, alignment: .center)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.1, alignment: .center)
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.14, alignment: .bottom)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("ClownBlue"), Color("ClownLightBlue")]), startPoint: .zero, endPoint: .trailing)
            )
            .clipped()
            .shadow(color: Color.black.opacity(0.8), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0.0)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.15, alignment: .top)
        .background(Color("ClownBlue"))
    }
}

struct ProfileMiddle: View {
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    VStack {
                        
                    }
                    .frame(width: UIScreen.screenHeight * 0.2, height: UIScreen.screenHeight * 0.2, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(1000)
                    .overlay(
                        Image("jan")
                            .resizable()
                            .cornerRadius(1000)
                            .ignoresSafeArea()
                            .frame(width: UIScreen.screenHeight * 0.2, height: UIScreen.screenHeight * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    )
                }
                .frame(width: UIScreen.screenHeight * 0.26, height: UIScreen.screenHeight * 0.26, alignment: .center)
                .background(Color("ClownSecondRing").opacity(0.23))
                .cornerRadius(1000)
            }
            .padding()
            .frame(width: UIScreen.screenHeight * 0.32, height: UIScreen.screenHeight * 0.32, alignment: .center)
            .background(Color("ClownFirstRing").opacity(0.15))
            .cornerRadius(1000)
            
            VStack {
                RoundedRectangle(cornerRadius: 1000)
                    .fill(Color("ClownProfileGreen"))
                    .frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.06, alignment: .center)
                    .overlay(
                        Text("Gregory")
                            .font(.system(size: 22))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                    )
                
                RoundedRectangle(cornerRadius: 1000)
                    .fill(Color("ClownYellow"))
                    .frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenHeight * 0.04, alignment: .center)
                    .overlay(
                        Text("18420")
                            .font(.system(size: 14))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                    )
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.32, alignment: .bottom)
        }
        .padding(.top)
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.35, alignment: .center)
        .background(Color("ClownBlue"))
    }
}

struct ProfileBottom: View {
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.05, alignment: .center)
                .background(Color("ClownBlue"))
                
                VStack {
                    
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.45, alignment: .center)
                .background(Color.white)
            }
            
            VStack {
                VStack {
                    VStack {
                        Text("Achievements")
                            .foregroundColor(Color("ClownGray"))
                            .font(.system(size: 20))
                            .bold()
                            .padding()
                    }
                    .frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.07, alignment: .leading)
                    
                    VStack {
                        
                    }
                    .frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.15, alignment: .center)
                }
                .frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.22, alignment: .center)
                .background(Color.white)
                .cornerRadius(10.0)
                .shadow(color: .gray, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    
                Spacer()
            
                VStack {
                    VStack {
                        Text("Statistics")
                            .foregroundColor(Color("ClownGray"))
                            .font(.system(size: 20))
                            .bold()
                            .padding()
                    }
                    .frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.07, alignment: .leading)
                    
                    VStack {
                        
                    }
                    .frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.15, alignment: .center)
                }
                .frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight * 0.22, alignment: .center)
                .background(Color.white)
                .cornerRadius(10.0)
                .shadow(color: .gray, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.46)
        }
        .padding(.top, -10)
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.5, alignment: .top)
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                ProfileTop()
                ProfileMiddle()
                ProfileBottom()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color("ClownBlue")).ignoresSafeArea()
        }.navigationBarTitle("")
        .navigationBarHidden(true)
            
       
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProfileTop()
            ProfileMiddle()
            ProfileBottom()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("ClownBlue")).ignoresSafeArea()
    }
}
