import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var game: QuizGame

    var body: some View {
        Group {
            switch game.phase {
            case .setup:
                SetupView()

            case .playing:
                GameView()

            case .results:
                Text("Game Finished!")
                    .font(.largeTitle)
            }
        }
    }
}
