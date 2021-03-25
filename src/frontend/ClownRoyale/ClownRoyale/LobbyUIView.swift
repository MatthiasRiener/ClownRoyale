
import SwiftUI

//Einzelner Player mit Profilbild, Namen und Ready Status
struct Player: View {
    var body: some View {
        
        HStack(){
            //Profilbild
            ProfilePicUIView()
                .frame(height: 60)

            //Username
            Text("Hans_Peter")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            Spacer()
            
            //Status
            Text("Ready")
                .fontWeight(.bold)
                .padding(.horizontal, 15.0)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(
                        cornerRadius: 25)
                        .fill(Color("ClownYellow")))
                //.opacity(0.5)
                .foregroundColor(.white)
                .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
        }
        .padding(.vertical, 20)
        .background(Color.white)
        
        Divider()
    }
}

//Auflistung aller Player in einem Raum
struct PlayerRoom: View {
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 0){
                Player()
                Player()
                Player()
                Player()
                Player()
                Player()
                Player()
                Player()
            }
            .padding(.all, 15.0)
            .background(
                RoundedRectangle(
                    cornerRadius: 40)
                    .fill(Color.white))
        }

    }
}

//Gesamte Lobby View
struct LobbyUIView: View {
    var body: some View {
        NavigationView {
        ZStack {
            Color("ClownYellowBackground")
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                Text("WAITING...")
                    .fontWeight(.bold)
                    .foregroundColor(Color("ClownYellow"))
                    .font(.largeTitle)
                    .padding()
                
                PlayerRoom()
                    .padding(.horizontal, 15)
                
                Text("READY UP")
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
            .background(Color("ClownYellowBackground"))
        }.hiddenNavigationBarStyle()
            
        }
        
    }
}

struct LobbyUIView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyUIView()
    }
}
