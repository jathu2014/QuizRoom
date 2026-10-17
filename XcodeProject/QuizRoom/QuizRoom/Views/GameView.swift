import SwiftUI

struct GameView: View {
    @EnvironmentObject private var game: QuizGame

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("QuizRoom")
                    .font(.largeTitle.bold())

                Text("Question \(game.questionNumber) of \(game.questions.count)")
                    .foregroundStyle(.secondary)

                if let player = game.currentPlayer {
                    Text("\(player.name)'s turn")
                        .font(.title2)
                }

                if let question = game.currentQuestion {
                    Text(question.text)
                        .font(.title)
                        .bold()

                    VStack(spacing: 18) {
                        ForEach(question.options.indices, id: \.self) { index in
                            AnswerButton(
                                index: index,
                                text: question.options[index],
                                isSelected: game.selectedAnswerIndex == index,
                                isCorrectAnswer: question.isCorrect(answerIndex: index),
                                hasAnswered: game.hasAnswered,
                                onSelect: {
                                    game.submitAnswer(index)
                                }
                            )
                        }
                    }

                    if game.hasAnswered {
                        Text(game.lastAnswerWasCorrect == true
                             ? "Correct answer!"
                             : "Incorrect answer!")
                            .font(.title2.bold())
                            .foregroundStyle(
                                game.lastAnswerWasCorrect == true
                                ? .green : .red
                            )

                        Text(question.explanation)
                            .font(.body)

                        Button(game.isLastQuestion ? "See Results" : "Next Question") {
                            game.nextQuestion()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding(70)
            .frame(maxWidth: 1400, alignment: .leading)
        }
    }
}
