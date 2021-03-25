//
//  CategorySelectionView.swift
//  ClownRoyale
//
//  Created by Simon Koll on 24.03.21.
//

import Foundation

import SwiftUI

struct Category: View {
    var ppv: Int //Points per vote - depending on category complexity
    var catName: String //Category Name
    var body: some View {
        
        HStack(){
            Text(catName)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            Spacer()
    
            Text("\(ppv)")
                .fontWeight(.bold)
                .padding(.horizontal, 15.0)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(
                        cornerRadius: 25)
                        .fill(Color("ClownYellow")))
                .foregroundColor(.white)
                .font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
        }
        .padding(.vertical, 15)
        .background(Color.white)
        
        Divider()
    }
}

struct CategoryBox: View {
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 0){
                Category(ppv: 50, catName: "Dark Humor")
                Category(ppv: 30, catName: "Lightbulb Jokes")
                Category(ppv: 35, catName: "Flat Humor")
                Category(ppv: 20, catName: "Animal Jokes")
                Category(ppv: 40, catName: "Cheesy Puns")
                Category(ppv: 10, catName: "Food Jokes")
                Category(ppv: 25, catName: "Political Jokes")
            }
            .padding(.all, 10)
            .background(
                RoundedRectangle(
                    cornerRadius: 40)
                    .fill(Color.white))
        }

    }
}

struct CategorySelectionView: View {
    var body: some View {
        NavigationView {
        ZStack {
            Color("ClownYellowBackground")
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                Text("Choose your")
                    .fontWeight(.thin)
                    .foregroundColor(Color("ClownYellow"))
                    .font(.largeTitle)

                Text("Category...")
                    .fontWeight(.bold)
                    .foregroundColor(Color("ClownYellow"))
                    .font(.largeTitle)
                    .padding(.bottom, 20)

                CategoryBox()
                    .padding(.horizontal, 15)
                NavigationLink(destination: GamePerspectiveOwnView()) {
                    Text("NEXT")
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
                            .edgesIgnoringSafeArea(.all)).background(Color("ClownYellowBackground"))
                }
                }
                
                
        }.hiddenNavigationBarStyle()
        }.hiddenNavigationBarStyle()
    }
}
struct CategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectionView()
    }
}

