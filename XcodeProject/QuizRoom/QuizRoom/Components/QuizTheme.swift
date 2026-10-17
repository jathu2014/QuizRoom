import SwiftUI

enum QuizTheme {
    static let background = Color(
        red: 0.05,
        green: 0.07,
        blue: 0.13
    )

    static let surface = Color(
        red: 0.10,
        green: 0.13,
        blue: 0.21
    )

    static let accent = Color(
        red: 0.45,
        green: 0.80,
        blue: 1.00
    )

    static let primaryText = Color.white

    static let secondaryText = Color(
        red: 0.76,
        green: 0.80,
        blue: 0.87
    )

    static let correct = Color(
        red: 0.40,
        green: 0.90,
        blue: 0.65
    )

    static let incorrect = Color(
        red: 1.00,
        green: 0.60,
        blue: 0.58
    )

    static let cornerRadius: CGFloat = 24
}

// Shared styling for information panels.
// Interactive buttons will receive their own focus styling.
struct QuizCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(28)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .background(QuizTheme.surface)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: QuizTheme.cornerRadius,
                    style: .continuous
                )
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius: QuizTheme.cornerRadius,
                    style: .continuous
                )
                .stroke(
                    Color.white.opacity(0.12),
                    lineWidth: 1
                )
            }
    }
}

extension View {
    func quizCard() -> some View {
        modifier(QuizCardModifier())
    }
}