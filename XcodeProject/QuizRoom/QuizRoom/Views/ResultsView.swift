import SwiftUI

struct ResultsView: View {
    @EnvironmentObject private var game: QuizGame

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("QuizRoom")
                    .font(.largeTitle.bold())

                Text("Final Results")
                    .font(.title)

                if game.winners.count == 1,
                   let winner = game.winners.first {
                    Label(
                        "\(winner.name) wins!",
                        systemImage: "trophy.fill"
                    )
                    .font(.title2.bold())
                    .foregroundStyle(.yellow)
                } else if !game.winners.isEmpty {
                    Text("It's a tie!")
                        .font(.title2.bold())

                    Text(
                        game.winners
                            .map(\.name)
                            .joined(separator: " & ")
                    )
                }

                Text("Leaderboard")
                    .font(.title2.bold())

                ForEach(
                    Array(game.leaderboard.enumerated()),
                    id: \.element.id
                ) { position, player in
                    HStack {
                        Text("\(position + 1). \(player.name)")
                        Spacer()
                        Text("\(player.score) points")
                            .bold()
                    }
                    .padding()
                    .background(
                        Color.white.opacity(0.1),
                        in: RoundedRectangle(cornerRadius: 12)
                    )
                }

                HStack(spacing: 20) {
                    Button("Play Again") {
                        game.playAgain()
                    }

                    Button("New Game") {
                        game.returnToSetup()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(60)
            .frame(maxWidth: 1000)
            .frame(maxWidth: .infinity)
        }
        .background(
            QuizTheme.background.ignoresSafeArea()
        )
    }
}
