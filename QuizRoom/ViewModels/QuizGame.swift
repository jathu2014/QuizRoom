import Foundation
import Combine

enum GamePhase {
    case setup
    case playing
    case results
}

@MainActor
final class QuizGame: ObservableObject {
    @Published private(set) var phase: GamePhase = .setup
    @Published private(set) var players: [QuizPlayer] = []
    @Published private(set) var questions: [QuizQuestion] = []

    @Published private(set) var selectedCategory: QuizCategory =
        .generalKnowledge

    @Published private(set) var currentQuestionIndex = 0
    @Published private(set) var selectedAnswerIndex: Int? = nil

    @Published var errorMessage: String? = nil

    // Everyone receives the same number of turns.
    let questionsPerPlayer = 2

    var currentQuestion: QuizQuestion? {
        guard questions.indices.contains(currentQuestionIndex) else {
            return nil
        }

        return questions[currentQuestionIndex]
    }

    var currentPlayerIndex: Int? {
        guard !players.isEmpty else {
            return nil
        }

        return currentQuestionIndex % players.count
    }

    var currentPlayer: QuizPlayer? {
        guard let index = currentPlayerIndex else {
            return nil
        }

        return players[index]
    }

    var questionNumber: Int {
        questions.isEmpty ? 0 : currentQuestionIndex + 1
    }

    var currentRound: Int {
        guard !players.isEmpty else {
            return 0
        }

        return currentQuestionIndex / players.count + 1
    }

    var hasAnswered: Bool {
        selectedAnswerIndex != nil
    }

    var lastAnswerWasCorrect: Bool? {
        guard let question = currentQuestion,
              let answer = selectedAnswerIndex else {
            return nil
        }

        return question.isCorrect(answerIndex: answer)
    }

    var isLastQuestion: Bool {
        !questions.isEmpty &&
            currentQuestionIndex == questions.count - 1
    }

    // Equal scores retain the original player order.
    // The results screen will identify shared winners.
    var leaderboard: [QuizPlayer] {
        players.enumerated()
            .sorted { first, second in
                if first.element.score != second.element.score {
                    return first.element.score > second.element.score
                }

                return first.offset < second.offset
            }
            .map { $0.element }
    }

    var winners: [QuizPlayer] {
        guard phase == .results,
              let highestScore = players.map(\.score).max() else {
            return []
        }

        return players.filter { $0.score == highestScore }
    }

    @discardableResult
    func startGame(
        names: [String],
        category: QuizCategory
    ) -> Bool {
        errorMessage = nil

        let cleanedNames = names.map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        guard (2...4).contains(cleanedNames.count) else {
            errorMessage = "Choose between two and four players."
            return false
        }

        guard cleanedNames.allSatisfy({
            !$0.isEmpty && $0.count <= 20
        }) else {
            errorMessage = "Each player needs a name of 1–20 characters."
            return false
        }

        let uniqueNames = Set(
            cleanedNames.map { $0.lowercased() }
        )

        guard uniqueNames.count == cleanedNames.count else {
            errorMessage = "Give each player a different name."
            return false
        }

        let availableQuestions = QuestionBank.questions(
            for: category
        )

        guard availableQuestions.allSatisfy({ $0.isValid }) else {
            errorMessage = "This category contains an invalid question."
            return false
        }

        let uniqueQuestionIDs = Set(
            availableQuestions.map(\.id)
        )

        guard uniqueQuestionIDs.count == availableQuestions.count else {
            errorMessage = "This category contains duplicate question IDs."
            return false
        }

        let requiredCount =
            cleanedNames.count * questionsPerPlayer

        guard availableQuestions.count >= requiredCount else {
            errorMessage = "There are not enough questions for this game."
            return false
        }

        players = cleanedNames.map {
            QuizPlayer(name: $0)
        }

        questions = Array(
            availableQuestions.shuffled().prefix(requiredCount)
        )

        selectedCategory = category
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        phase = .playing

        return true
    }

    func submitAnswer(_ answerIndex: Int) {
        // Ignore repeated presses after an answer is submitted.
        guard phase == .playing,
              selectedAnswerIndex == nil,
              let question = currentQuestion,
              let playerIndex = currentPlayerIndex,
              question.options.indices.contains(answerIndex) else {
            return
        }

        selectedAnswerIndex = answerIndex

        players[playerIndex].recordAnswer(
            isCorrect: question.isCorrect(
                answerIndex: answerIndex
            )
        )
    }

    func nextQuestion() {
        // Require an answer before advancing.
        guard phase == .playing,
              hasAnswered else {
            return
        }

        if isLastQuestion {
            phase = .results
        } else {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
        }
    }

    func playAgain() {
        guard phase == .results else {
            return
        }

        let names = players.map(\.name)

        startGame(
            names: names,
            category: selectedCategory
        )
    }

    func returnToSetup() {
        phase = .setup
        players = []
        questions = []
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        errorMessage = nil
    }
}