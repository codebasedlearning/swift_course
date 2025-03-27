// (C) 2025 A.Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

/*
 Apart from the private vars, the rest is the same as in A1.
 */

import SwiftUI

@main
struct A4_SimpleBoardGameApp: App {
    @State private var highscoreModel = HighscoreViewModel()
    @State private var heartbeatModel = HeartbeatViewModel()
    @State private var boardModel = TicTacToeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(highscoreModel)
                .environment(heartbeatModel)
                .environment(boardModel)
                .onAppear {
                    heartbeatModel.onNewReading = { bpm in highscoreModel.score = bpm }
                    heartbeatModel.isActive = true
                }
        }
        
    }
}
