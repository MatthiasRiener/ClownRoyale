import SwiftUI

struct ProfileView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        Text("Profile")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .bold()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.1, alignment: .center)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("ClownYellow"), Color("ClownYellow")]), startPoint: .zero, endPoint: .trailing)
                    )
                    
                    ZStack {
                        VStack {
                            VStack {
                                VStack {
                                    
                                }
                                .frame(width: geometry.size.height * 0.2, height: geometry.size.height * 0.2, alignment: .center)
                                .background(Color.black)
                                .cornerRadius(1000)
                            }
                            .frame(width: geometry.size.height * 0.25, height: geometry.size.height * 0.25, alignment: .center)
                            .background(Color.green)
                            .cornerRadius(1000)
                        }
                        .frame(width: geometry.size.height * 0.3, height: geometry.size.height * 0.3, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(1000)
                        VStack {
                            VStack {
                                Text("Gregory")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 25))
                                    .bold()
                            }
                            .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.08, alignment: .center)
                            .background(Color.red)
                            .cornerRadius(50)
                            Spacer()
                            VStack {
                                Text("18420")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 15))
                            }
                            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.04, alignment: .center)
                            .background(Color.red)
                            .cornerRadius(50)
                        }
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.13, alignment: .top)
                        .background(Color.blue)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.35, alignment: .center)
                    .background(Color.blue)
                    
                    VStack {
                        ZStack {
                            VStack {
                                HStack {
                                    
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.05)
                                .background(Color.blue)
                                HStack {
                                    
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
                                .background(Color.white)
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
                            .background(Color.green)
                            VStack {
                                VStack {
                                    Text("Test1")
                                }
                                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.26)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                
                                Spacer()
                                
                                VStack {
                                    Text("Test")
                                }
                                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.26)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                            }
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.55)

                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.55, alignment: .top)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
