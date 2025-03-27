// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

/*
 Screens now live in this file. But apart from that, nothing new.
 */

import SwiftUI

struct PlayScreen: View {
    var body: some View {
        ZStack {
            Image("pirates_lego_ship1")
                .resizable()
                .scaledToFill()
                .opacity(0.6)
                .ignoresSafeArea()
            VStack {
                Button("What will we do with a drunken sailor?") {}
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.all, 10)
            }
            .padding()
            .background(Color.mint.opacity(0.5))
            .cornerRadius(20)
        }
    }
}

struct SettingsScreen: View {
    var body: some View {
        ZStack {
            Image("pirates_lego_ship2")
                .resizable()
                .scaledToFill()
                .opacity(0.6)
                .ignoresSafeArea()
            VStack {
                Button("Early in the morning!") {}
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.all, 10)
            }
            .padding()
            .background(Color.mint.opacity(0.5))
            .cornerRadius(20)
        }
    }
}
