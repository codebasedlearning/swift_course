// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

/*
 Here we have the '@Environment' property wrapper used to read values from SwiftUI’s environment system.
 
 Then we also work with collections, namely 'Array' and 'ForEach'.
 */

import SwiftUI

struct TicTacToeScreen: View {
    @Environment(TicTacToeViewModel.self) private var game
    @Environment(HighscoreViewModel.self) private var highscore
    
    var body: some View {
        ZStack {
            Image("street_board_game")
                .resizable()
                .scaledToFill()
                .opacity(0.6)
                .ignoresSafeArea()
            VStack(spacing:0) {
                Divider()
                HeaderText(text: "Tic Tac Toe")
                    .padding(.bottom, 20)
                
                BPMView()
                TicTacToeView()

                Button("Reset") { game.reset(); highscore.reset() }
                    .bold()
                    .foregroundColor(.black)
                    .padding(.all, 20)
                    .background(Color.orange.opacity(0.6))
                    .cornerRadius(20)
                Spacer()
            }
        }
    }
}

struct BPMView: View {
    @Environment(HeartbeatViewModel.self) private var heartbeat
    @Environment(HighscoreViewModel.self) private var highscore

    var body: some View {
        // somewhat tricky here, we cannot use the model from @Environment (only read)
        // and had to use @Bindable (or cast it in Bindable()) for two-way data binding
        @Bindable var heartbeat = heartbeat
        ZStack {
            let bpm = heartbeat.currentBPM > 0 ? "\(heartbeat.currentBPM)" : "-"
            Text("Player \(bpm) [\(highscore.score)] BPM")
                .font(.title3)
                .foregroundColor(.orange)
            HStack(spacing: 5) {
                Spacer()
                Toggle("", isOn: $heartbeat.isActive)
                    .labelsHidden()
                    // .onChange(of: heartbeat.isActive) { }
                    .padding(.trailing, 20)
            }
        }
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(.black.opacity(0.5))
    }
}

struct TicTacToeView: View {
    @Environment(TicTacToeViewModel.self) private var game
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<9, id: \.self) { index in
                ZStack {
                    Rectangle()
                        .foregroundColor(.mint.opacity(0.8))
                        .frame(height: 120)
                        .cornerRadius(8)
                    Text(game.board[index].rawValue)
                        .font(.system(size: 40))
                }
                .onTapGesture {
                    game.tap(at: index)
                }
            }
        }
        .padding()
    }
}
