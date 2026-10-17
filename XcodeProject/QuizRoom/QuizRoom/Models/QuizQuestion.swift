import Foundation

enum QuizCategory: String, CaseIterable, Identifiable {
    case generalKnowledge = "General Knowledge"
    case scienceAndTechnology = "Science & Technology"

    var id: String {
        rawValue
    }

    var symbol: String {
        switch self {
        case .generalKnowledge:
            return "globe"
        case .scienceAndTechnology:
            return "atom"
        }
    }
}

// One multiple-choice question with an explanation.
struct QuizQuestion: Identifiable, Equatable {
    let id: String
    let category: QuizCategory
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String

    // A valid question must have four non-empty, distinct choices.
    var isValid: Bool {
        let cleanedOptions = options.map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return !id.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty &&
            !text.trimmingCharacters(
                in: .whitespacesAndNewlines
            ).isEmpty &&
            !explanation.trimmingCharacters(
                in: .whitespacesAndNewlines
            ).isEmpty &&
            options.count == 4 &&
            cleanedOptions.allSatisfy { !$0.isEmpty } &&
            Set(cleanedOptions.map { $0.lowercased() }).count == 4 &&
            options.indices.contains(correctAnswerIndex)
    }

    func isCorrect(answerIndex: Int) -> Bool {
        guard isValid,
              options.indices.contains(answerIndex) else {
            return false
        }

        return answerIndex == correctAnswerIndex
    }

    var correctAnswer: String? {
        guard options.indices.contains(correctAnswerIndex) else {
            return nil
        }

        return options[correctAnswerIndex]
    }
}