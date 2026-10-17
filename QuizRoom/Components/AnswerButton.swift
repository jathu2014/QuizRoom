import SwiftUI

struct AnswerButton: View {
    let index: Int
    let text: String
    let isSelected: Bool
    let isCorrectAnswer: Bool
    let hasAnswered: Bool
    let onSelect: () -> Void

    @FocusState private var isFocused: Bool

    @Environment(\.accessibilityReduceMotion)
    private var reduceMotion

    private var optionLetter: String {
        let letters = ["A", "B", "C", "D"]

        guard letters.indices.contains(index) else {
            return "?"
        }

        return letters[index]
    }

    private var feedbackColor: Color {
        if hasAnswered && isCorrectAnswer {
            return QuizTheme.correct
        }

        if hasAnswered && isSelected {
            return QuizTheme.incorrect
        }

        return QuizTheme.accent
    }

    private var borderColor: Color {
        if hasAnswered && (isCorrectAnswer || isSelected) {
            return feedbackColor
        }

        return isFocused
            ? QuizTheme.accent
            : Color.white.opacity(0.18)
    }

    private var feedbackText: String {
        guard hasAnswered else {
            return ""
        }

        if isCorrectAnswer {
            return isSelected
                ? "Correct — your answer"
                : "Correct answer"
        }

        return isSelected ? "Incorrect — your answer" : ""
    }

    var body: some View {
        Button(action: onSelect) {
            HStack(alignment: .top, spacing: 20) {
                Text(optionLetter)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(QuizTheme.background)
                    .frame(width: 48, height: 48)
                    .background(feedbackColor)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )

                VStack(alignment: .leading, spacing: 10) {
                    Text(text)
                        .font(.title3.weight(.medium))
                        .foregroundStyle(QuizTheme.primaryText)
                        .multilineTextAlignment(.leading)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )

                    if !feedbackText.isEmpty {
                        Label(
                            feedbackText,
                            systemImage: isCorrectAnswer
                                ? "checkmark.circle.fill"
                                : "xmark.circle.fill"
                        )
                        .font(.body.weight(.semibold))
                        .foregroundStyle(feedbackColor)
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            }
            .padding(24)
            .frame(
                maxWidth: .infinity,
                minHeight: 112,
                alignment: .leading
            )
            .background(
                isFocused
                    ? QuizTheme.accent.opacity(0.16)
                    : QuizTheme.surface
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: QuizTheme.cornerRadius
                )
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius: QuizTheme.cornerRadius
                )
                .stroke(
                    borderColor,
                    lineWidth: isFocused ? 4 : 2
                )
            }
            .scaleEffect(
                isFocused && !reduceMotion ? 1.025 : 1
            )
            .animation(
                reduceMotion
                    ? nil
                    : .easeOut(duration: 0.15),
                value: isFocused
            )
        }
        .buttonStyle(.plain)
        .focused($isFocused)
        .disabled(hasAnswered)
        .accessibilityLabel(
            "Option \(optionLetter): \(text)"
        )
        .accessibilityValue(feedbackText)
        .accessibilityIdentifier("answerOption\(index)")
    }
}