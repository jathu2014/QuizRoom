import SwiftUI

struct SetupView: View {
    @EnvironmentObject private var game: QuizGame

    @State private var playerCount = 2
    @State private var playerNames = [
        "Player 1",
        "Player 2",
        "Player 3",
        "Player 4"
    ]

    @State private var selectedCategory: QuizCategory =
        .generalKnowledge

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 36) {
                introduction

                HStack(alignment: .top, spacing: 36) {
                    playerPanel

                    categoryPanel
                }

                startPanel
            }
            .padding(60)
            .frame(maxWidth: 1600)
            .frame(maxWidth: .infinity)
        }
        .background(
            QuizTheme.background.ignoresSafeArea()
        )
        .alert(
            "Check your game setup",
            isPresented: Binding(
                get: { game.errorMessage != nil },
                set: { isPresented in
                    if !isPresented {
                        game.errorMessage = nil
                    }
                }
            )
        ) {
            Button("OK", role: .cancel) {
                game.errorMessage = nil
            }
        } message: {
            Text(game.errorMessage ?? "Please try again.")
        }
    }

    private var introduction: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(
                "QuizRoom",
                systemImage: "person.3.fill"
            )
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(QuizTheme.primaryText)

            Text("One screen. Friendly competition.")
                .font(.title3)
                .foregroundStyle(QuizTheme.secondaryText)
        }
    }

    private var playerPanel: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Who's playing?")
                .font(.title2.weight(.semibold))
                .foregroundStyle(QuizTheme.primaryText)

            HStack(spacing: 24) {
                Button {
                    playerCount -= 1
                } label: {
                    Image(systemName: "minus")
                }
                .disabled(playerCount <= 2)
                .accessibilityLabel("Remove a player")

                Text("\(playerCount) players")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(QuizTheme.primaryText)
                    .monospacedDigit()

                Button {
                    playerCount += 1
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(playerCount >= 4)
                .accessibilityLabel("Add a player")
            }

            ForEach(0..<playerCount, id: \.self) { index in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Player \(index + 1)")
                        .font(.caption)
                        .foregroundStyle(QuizTheme.secondaryText)

                    TextField(
                        "Enter a name",
                        text: $playerNames[index]
                    )
                    .accessibilityLabel("Player \(index + 1) name")
                    .accessibilityIdentifier("playerName\(index)")
                }
            }

            Text("Choose different names, up to 20 characters each.")
                .font(.caption)
                .foregroundStyle(QuizTheme.secondaryText)
        }
        .quizCard()
        .focusSection()
    }

    private var categoryPanel: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Choose a category")
                .font(.title2.weight(.semibold))
                .foregroundStyle(QuizTheme.primaryText)

            ForEach(QuizCategory.allCases) { category in
                Button {
                    selectedCategory = category
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: category.symbol)

                        Text(category.rawValue)
                            .multilineTextAlignment(.leading)

                        Spacer()

                        if selectedCategory == category {
                            Image(systemName: "checkmark.circle.fill")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .accessibilityValue(
                    selectedCategory == category
                        ? "Selected"
                        : "Not selected"
                )
            }

            Divider()
                .overlay(QuizTheme.secondaryText.opacity(0.3))

            VStack(alignment: .leading, spacing: 14) {
                Text("How to play")
                    .font(.headline)
                    .foregroundStyle(QuizTheme.primaryText)

                Text("• Pass the remote to the player whose turn is shown.")
                Text("• Each player answers \(game.questionsPerPlayer) questions.")
                Text("• A correct answer earns 10 points.")
                Text("• Review the explanation before the next turn.")
                Text("• Equal top scores share the win.")
            }
            .font(.body)
            .foregroundStyle(QuizTheme.secondaryText)
        }
        .quizCard()
        .focusSection()
    }

    private var startPanel: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(
                "\(playerCount * game.questionsPerPlayer) questions · \(selectedCategory.rawValue)"
            )
            .font(.body)
            .foregroundStyle(QuizTheme.secondaryText)

            Button {
                game.startGame(
                    names: Array(playerNames.prefix(playerCount)),
                    category: selectedCategory
                )
            } label: {
                Label(
                    "Start game",
                    systemImage: "play.fill"
                )
                .font(.title3.weight(.semibold))
                .padding(.horizontal, 24)
            }
            .accessibilityIdentifier("startGameButton")
        }
        .focusSection()
    }
}