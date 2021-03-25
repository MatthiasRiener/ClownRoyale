
import SwiftUI

struct Tent: View {
    @State var gradient = [Color.red, Color.red.opacity(0.3)]
    
    var positionY: Int
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: .bottom, endPoint: .top))
    }
}


struct PlayButton: View {
    
    var bg: Color
    var text: String
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .fill(bg)
            .frame(width: UIScreen.screenWidth / 10 * 4, height: 90, alignment: .center)
            .overlay(
                Text("\(text)")
                    .font(.system(size: 21))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
            )
    }
}


struct ProfileStart: View {
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Image("jan")
                .resizable()
                .cornerRadius(1000)
                .ignoresSafeArea()
                .frame(width: UIScreen.screenHeight * 0.2, height: UIScreen.screenHeight * 0.2, alignment: .center)
        
            
                RoundedRectangle(cornerRadius: 1000)
                    .fill(Color("ClownProfileGreen"))
                    .frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.06, alignment: .center)
                    .overlay(
                        NavigationLink(destination: ProfileView()) {
                            Text("Gregory")
                                .font(.system(size: 22))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                        }
                        
                    )
        }
    }
}


struct MenuSwiftUIView: View {
    
    @State private var goToShop: Bool = false

    var body: some View {
        NavigationView {
             
        ZStack {
            Color("ClownYellowBackground")
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                
                Image("bus")
                    .resizable()
                    .aspectRatio(contentMode:.fill)
                    .ignoresSafeArea()
 
                
                HStack(alignment: .center, spacing: 20){
                    ForEach((0...6), id: \.self) {
                        Tent(positionY: $0)
                    }
                }
                Text("WELCOME BACK")
                    .font(.title)
                    .fontWeight(.bold)
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
                    .edgesIgnoringSafeArea(.all))
            }
            
            ZStack{
                RoundedRectangle(cornerRadius: 30.0)
                    .fill(Color.white)
                    .frame(width: UIScreen.screenWidth / 10 * 9, height: UIScreen.screenWidth / 10 * 9.5, alignment: .center)
                
                VStack(alignment: .center, spacing: 20){
                    ProfileStart()
                    HStack() {
                        NavigationLink(destination: LobbyUIView()) {
                            PlayButton(bg: Color("ClownRed"), text: "PLAY")
                        }
                        
                        NavigationLink(destination: LoadingUIView()) {
                            
                            PlayButton(bg: Color("ClownRed"), text: "CUSTOM GAME")
                                .opacity(0.5)
                        }
                    }
                }
            }
            
            HStack{
                Spacer()

                    VStack(alignment: .center, spacing: 0){
                        NavigationLink(destination: BoutiqueView()) {
                            Text("SHOP")
                                .fontWeight(.bold)
                                .padding()
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 25)
                                        .fill(Color("ClownYellow"))
                                )
                                .foregroundColor(.white)
                                .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                            
                        }
                        Spacer()
                        
                    }
                    .offset(x: UIScreen.screenWidth * -0.185, y: 0)
                    
            }
        }.hiddenNavigationBarStyle()
        

        }.hiddenNavigationBarStyle()
       
        

        
    }
}

struct MenuSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MenuSwiftUIView()
    }
}
