//
//  BackgroundView.swift
//  Bullseye
//
//  Created by Анатолий Фетелеу on 13.06.2022.
//

import SwiftUI

struct BackgroundView: View {
    @Binding var game: Game
    
    var body: some View {
        VStack {
            TopView(game: $game)
            Spacer()
            BottomView(game: $game)
        }
        .padding()
        .background(
            RingsView()
        )
        .edgesIgnoringSafeArea(.all )
    }
}

struct TopView: View {
    @Binding var game: Game
    @State private var leaderboardIsShowing: Bool = false
    
    var body: some View {
        HStack{
            Button(action: { game.restart() }, label: {
                RoundedImageViewStroked(systemName: "arrow.counterclockwise")
            })
            Spacer()
            Button(action: { leaderboardIsShowing = true }, label: {
                RoundedImageViewFilled(systemName: "list.dash")
            }).sheet(isPresented: $leaderboardIsShowing, onDismiss: {}, content: {
                LeaderboardView(leaderboardIsShowing: $leaderboardIsShowing, game: $game)
            })
        }
    }
}

struct NumberView: View {
    var title: String
    var text: String
    
    var body: some View {
        VStack(spacing: 5) {
            LabelText(text: title)
            RoundRectTextView(text: text)
        }
    }
}

struct BottomView: View {
    @Binding var game: Game
    
    var body: some View {
        HStack {
            NumberView(title: "Score", text: String(game.score))
            Spacer()
            NumberView(title: "Round", text: String(game.round))
        }
    }
}

struct RingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            ForEach(1..<5) { ring in
                let size = CGFloat(ring * 100)
                let opacity = colorScheme == .dark ? 0.3 : 0.1
                Circle()
                    .stroke(lineWidth: 20.0)
                    .fill(
                        RadialGradient(colors: [Color("RingsColor").opacity(opacity), Color("RingsColor").opacity(0)],
                                       center: .center, startRadius: 100, endRadius: 300)
                    )
                    .frame(width: size, height: size)
            }
        }
    }
}
 
struct BackgroundView_Previews: PreviewProvider  {
    static var previews: some View {
        BackgroundView(game: .constant(Game()))
        BackgroundView(game: .constant(Game()))
            .preferredColorScheme(.dark)
    }
}
 
