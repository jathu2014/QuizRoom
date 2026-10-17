import Foundation

struct QuizPlayer: Identifiable, Equatable {
    let id: UUID
    var name: String

    private(set) var score = 0
    private(set) var answeredCount = 0
    private(set) var correctCount = 0

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
    }

    // Each correct answer earns 10 points.
    // Incorrect answers do not deduct points.
    mutating func recordAnswer(isCorrect: Bool) {
        answeredCount += 1

        if isCorrect {
            correctCount += 1
            score += 10
        }
    }

    // Prepare this player for another game.
    mutating func resetScore() {
        score = 0
        answeredCount = 0
        correctCount = 0
    }

    var accuracyPercentage: Int {
        guard answeredCount > 0 else {
            return 0
        }

        let accuracy =
            Double(correctCount) / Double(answeredCount)

        return Int((accuracy * 100).rounded())
    }
}