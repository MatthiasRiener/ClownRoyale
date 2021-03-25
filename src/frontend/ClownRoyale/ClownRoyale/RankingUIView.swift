//
//  RankingUIView.swift
//  ClownRoyale
//
//  Created by Jan Donnerbauer on 18.03.21.
//

import SwiftUI

struct TopRankingPlayer: View {
    var position: Int
    var body: some View {
        
        VStack(){
            Text("\(position)")
            .fontWeight(.black)
            //Profilbild
            ProfilePicUIView()
                .frame(height: 75)

            //Username
            Text("Hans_Peter")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            
            //Status
            Text("4269")
                .fontWeight(.bold)
                .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
        }
        .padding(.vertical, 20)
    }
}

struct RankingPlayer: View {
    var position: Int

    @State private var goToNewView: Bool = false

    
    var body: some View {
        

            HStack(){
                
                Text("\(position)")
                .fontWeight(.black)
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
                Text("4269")
                    .fontWeight(.bold)
                    .padding(.horizontal, 15.0)
                    .padding(.vertical, 10)
                    .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
            }
            .onTapGesture {
                self.goToNewView.toggle()
            }
            .padding(.vertical, 20)
            .background(Color.white)
        
        
    
        Divider()
        
        NavigationLink(destination: ProfileView(), isActive: self.$goToNewView) { EmptyView() }

    }
}

struct RankingPlayerGroup: View {
    @State private var willMoveToNextScreen = false

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
                
            
            VStack(alignment: .center, spacing: 0){
                HStack {
                    Text("Clowns")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text("54/89")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
                ForEach((4...10), id: \.self) {
                    RankingPlayer(position: $0)

                }
            }
            .padding(.all, 15.0)
            .background(
                RoundedRectangle(
                    cornerRadius: 40)
                    .fill(Color.white))
        }

    }
}

struct RankingUIView: View {
    @State private var showingSheet = false

    var body: some View {
       
        NavigationView {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [Color("ClownYellow"),
                             Color("ClownYellowBackground")]),
                startPoint: .top,
                endPoint: .bottom
                )
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0){
                
                Text("TOP CLOWNS")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                HStack(alignment: .top, spacing: 10 ){
                    TopRankingPlayer(position: 2)
                        .padding(.top, 35)
                    
                    TopRankingPlayer(position: 1)
                    
                    TopRankingPlayer(position: 3)
                        .padding(.top, 50)
                }
                .padding(.bottom, 20.0)
                
                RankingPlayerGroup()
                    .padding(.horizontal, 15)
                }
            }
        
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [Color("ClownYellow"),
                             Color("ClownYellowHell")]),
                startPoint: .leading,
                endPoint: .trailing
        ))
        .navigationBarTitle(Text("Clown Ranking"), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("i") {
                            showingSheet.toggle()
                        }
                        .sheet(isPresented: $showingSheet) {
                            RankingPoints()
                        }
            }
        } 

        }.hiddenNavigationBarStyle()
    }
}

struct RankingPoints : View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {

        VStack(alignment: .center, spacing: 0){
            HStack {
                Spacer()
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            Spacer()
            HStack {
                Text("Placement")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("Reward")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            
            Divider()
            
            HStack(){
                
                Text("first")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
        
                Spacer()
                
                //Status
                Text("100")
                    .fontWeight(.bold)
                    .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 25)
                            .fill(Color("ClownRed")))
            }
            .padding()
            .background(Color.white)
            
            Divider()
            
            HStack(){
                
                Text("second")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
        
                Spacer()
                
                //Status
                Text("50")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 25)
                            .fill(Color("ClownRed")))
            }
            .padding()
            .background(Color.white)
            
            Divider()
            
            HStack(){
                
                Text("third")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
        
                Spacer()
                
                //Status
                Text("20")
                    .fontWeight(.bold)
                    .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(
                            cornerRadius: 25, style: .circular)
                            .fill(Color("ClownRed")))
            }
            .padding()
            .background(Color.white)
            
            
            Spacer()
            
        }
        .padding(.all, 15.0)
        .background(
            RoundedRectangle(
                cornerRadius: 40)
                .fill(Color.white))
    }
}
    


struct RankingUIView_Previews: PreviewProvider {
    static var previews: some View {
        RankingUIView()
    }
}
