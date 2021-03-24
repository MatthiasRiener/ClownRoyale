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
            HStack {
                HStack {
                    VStack {
                        
                    }.frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenHeight * 0.1, alignment: .center)
                    
                    VStack {
                        Text("Clown Boutique")
                            .foregroundColor(Color("ClownGray"))
                            .font(.system(size: 26))
                            .bold()
                    }
                    .frame(width: UIScreen.screenWidth * 0.5, height: UIScreen.screenHeight * 0.1, alignment: .center)
                    
                    VStack {
                        Text("1536")
                            .foregroundColor(Color("ClownYellow"))
                            .font(.system(size: 20))
                            .bold()
                    }
                    .frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenHeight * 0.1, alignment: .center)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.1, alignment: .center)
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.14, alignment: .bottom)
            .background(Color.white)
            .clipped()
            .shadow(color: Color.black.opacity(0.8), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0.0)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.15, alignment: .top)
        .background(Color.white)
    }
}

struct BoutiqueMiddle: View {
    var body: some View {
        VStack {
            HStack {
                
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.05, alignment: .top)
            .background(Color.white)
            
            HStack {
                Text("TODAY")
                    .foregroundColor(Color("ClownGray"))
                    .font(.system(size: 26))
                    .bold()
                    .padding()
                Spacer()
                Text("8h 49min")
                    .foregroundColor(Color("ClownGray"))
                    .font(.system(size: 16))
                    .padding()
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.06, alignment: .top)
            .background(Color.white)
            
            ZStack {
                HStack {
                    HStack {
                        VStack {
                            HStack {
                                Text("FUNNY GLASSES")
                                    .foregroundColor(Color("ClownGray"))
                                    .font(.system(size: 18))
                                    .bold()
                            }
                            .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.04, alignment: .bottom)
                            
                            HStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("ClownGreen"))
                                    .frame(width: UIScreen.screenHeight * 0.06, height: UIScreen.screenHeight * 0.06, alignment: .center)
                                    .overlay(
                                        Image("Smiley")
                                            .resizable()
                                            .cornerRadius(1000)
                                            .ignoresSafeArea()
                                            .frame(width: UIScreen.screenHeight * 0.03, height: UIScreen.screenHeight * 0.03, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    )
                                    .shadow(color: .gray, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("ClownYellow"))
                                    .frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.06, alignment: .center)
                                    .overlay(
                                        Text("800")
                                            .font(.system(size: 20))
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(.white)
                                    )
                                    .shadow(color: .gray, radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                            }
                            .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.08, alignment: .top)
                        }
                        .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.12, alignment: .bottom)
                    }
                    .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.26, alignment: .bottom)
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(color: .gray, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.34, alignment: .bottom)
                
                HStack {
                    HStack {
                        
                    }
                    .frame(width: UIScreen.screenHeight * 0.2, height: UIScreen.screenHeight * 0.2, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(1000.0)
                    .shadow(color: .gray, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.34, alignment: .top)
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.34, alignment: .top)
            .background(Color.white)
            
            HStack {
                RoundedRectangle(cornerRadius: 1000.0)
                    .fill(Color.blue)
                    .frame(width: 7.5, height: 7.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 1)
                RoundedRectangle(cornerRadius: 1000.0)
                    .fill(Color.gray)
                    .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 1)
                
                RoundedRectangle(cornerRadius: 1000.0)
                    .fill(Color.gray)
                    .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 1)
                RoundedRectangle(cornerRadius: 1000.0)
                    .fill(Color.gray)
                    .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 1)
                
                RoundedRectangle(cornerRadius: 1000.0)
                    .fill(Color.gray)
                    .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 1)
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.05, alignment: .center)
            .background(Color.white)

        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.5, alignment: .top)
        .background(Color.white)
    }
}

struct BoutiqueBottom: View {
    var body: some View {
        VStack {
            HStack {
                
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.04, alignment: .top)
            .background(Color.white)
            
            HStack {
                Text("MONTHLY")
                    .foregroundColor(Color("ClownGray"))
                    .font(.system(size: 26))
                    .bold()
                    .padding()
                Spacer()
                Text("6T 8h")
                    .foregroundColor(Color("ClownGray"))
                    .font(.system(size: 16))
                    .padding()
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.06, alignment: .top)
            .background(Color.white)
            
            VStack {
                HStack {
                    HStack {
                        
                    }
                    .frame(width: UIScreen.screenWidth * 0.5, height: UIScreen.screenHeight * 0.17, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(10.0)
                    .shadow(color: .gray, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 90)
                    
                    HStack {
                        
                    }
                    .frame(width: UIScreen.screenWidth * 0.5, height: UIScreen.screenHeight * 0.17, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(10.0)
                    .shadow(color: .gray, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 50)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.20, alignment: .center)
                .background(Color.white)
                
                HStack {
                    RoundedRectangle(cornerRadius: 1000.0)
                        .fill(Color.blue)
                        .frame(width: 7.5, height: 7.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 1)
                    RoundedRectangle(cornerRadius: 1000.0)
                        .fill(Color.gray)
                        .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 1)
                    
                    RoundedRectangle(cornerRadius: 1000.0)
                        .fill(Color.gray)
                        .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 1)
                    RoundedRectangle(cornerRadius: 1000.0)
                        .fill(Color.gray)
                        .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 1)
                    
                    RoundedRectangle(cornerRadius: 1000.0)
                        .fill(Color.gray)
                        .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 1)
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.05, alignment: .center)
                .background(Color.white)
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.25, alignment: .bottom)
            .background(Color.white)
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
