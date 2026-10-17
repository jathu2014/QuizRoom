import SwiftUI

@main
struct QuizRoomApp: App {
    @StateObject private var game = QuizGame()

    var body: some Scene {
        WindowGroup {
            Group {
                switch game.phase {
                case .setup:
                    SetupView()

                case .playing:
                    GameView()

                case .results:
                    ResultsView()
                }
            }
            .environmentObject(game)
        }
    }
}
