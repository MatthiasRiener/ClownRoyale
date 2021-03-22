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
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("ClownYellowBackground")).ignoresSafeArea()
        
   
    }
}

struct GamePerspectiveTop: View {
    var body: some View {
        HStack() {
            Text("Was geht ab!")
        }.frame(width: .infinity, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct GamePerspectiveOwn_Previews: PreviewProvider {
    static var previews: some View {
        GamePerspectiveOwn()
    }
}
