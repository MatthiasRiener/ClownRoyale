//
//  ProfilePicUIView.swift
//  ClownRoyale
//
//  Created by Jan Donnerbauer on 11.03.21.
//

import SwiftUI

struct ProfilePicUIView: View {
    var body: some View {
        Image("bus")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
    }
}

struct ProfilePicUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicUIView()
    }
}
