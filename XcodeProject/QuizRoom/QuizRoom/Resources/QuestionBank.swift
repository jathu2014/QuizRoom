import Foundation

enum QuestionBank {
    static let all: [QuizQuestion] = [

        // MARK: - General Knowledge

        QuizQuestion(
            id: "general-01",
            category: .generalKnowledge,
            text: "Which ocean is the largest on Earth?",
            options: [
                "Atlantic Ocean",
                "Indian Ocean",
                "Pacific Ocean",
                "Arctic Ocean"
            ],
            correctAnswerIndex: 2,
            explanation: "The Pacific Ocean is Earth's largest ocean."
        ),

        QuizQuestion(
            id: "general-02",
            category: .generalKnowledge,
            text: "How many sides does a hexagon have?",
            options: [
                "Five",
                "Six",
                "Seven",
                "Eight"
            ],
            correctAnswerIndex: 1,
            explanation: "A hexagon is a polygon with six sides."
        ),

        QuizQuestion(
            id: "general-03",
            category: .generalKnowledge,
            text: "Which country is home to the ancient city of Kyoto?",
            options: [
                "China",
                "Thailand",
                "South Korea",
                "Japan"
            ],
            correctAnswerIndex: 3,
            explanation: "Kyoto is a city in Japan and was once its capital."
        ),

        QuizQuestion(
            id: "general-04",
            category: .generalKnowledge,
            text: "Which instrument normally has 88 keys?",
            options: [
                "Piano",
                "Violin",
                "Trumpet",
                "Flute"
            ],
            correctAnswerIndex: 0,
            explanation: "A standard modern piano has 52 white keys and 36 black keys."
        ),

        QuizQuestion(
            id: "general-05",
            category: .generalKnowledge,
            text: "In chess, which piece moves in an L-shaped pattern?",
            options: [
                "Bishop",
                "Rook",
                "Knight",
                "Queen"
            ],
            correctAnswerIndex: 2,
            explanation: "A knight moves two squares in one direction and one perpendicular to it."
        ),

        QuizQuestion(
            id: "general-06",
            category: .generalKnowledge,
            text: "What is the currency of Japan?",
            options: [
                "Won",
                "Yen",
                "Rupee",
                "Euro"
            ],
            correctAnswerIndex: 1,
            explanation: "Japan's currency is the yen."
        ),

        QuizQuestion(
            id: "general-07",
            category: .generalKnowledge,
            text: "How many minutes are in two and a half hours?",
            options: [
                "120",
                "135",
                "180",
                "150"
            ],
            correctAnswerIndex: 3,
            explanation: "Two hours is 120 minutes; another half-hour adds 30."
        ),

        QuizQuestion(
            id: "general-08",
            category: .generalKnowledge,
            text: "Which language is primarily spoken in Brazil?",
            options: [
                "Portuguese",
                "Spanish",
                "French",
                "Italian"
            ],
            correctAnswerIndex: 0,
            explanation: "Portuguese is Brazil's official and primary language."
        ),

        QuizQuestion(
            id: "general-09",
            category: .generalKnowledge,
            text: "Which continent is the Sahara Desert located in?",
            options: [
                "Asia",
                "Australia",
                "Africa",
                "South America"
            ],
            correctAnswerIndex: 2,
            explanation: "The Sahara stretches across much of North Africa."
        ),

        QuizQuestion(
            id: "general-10",
            category: .generalKnowledge,
            text: "How many degrees are in a right angle?",
            options: [
                "45",
                "90",
                "180",
                "360"
            ],
            correctAnswerIndex: 1,
            explanation: "A right angle measures exactly 90 degrees."
        ),

        // MARK: - Science & Technology

        QuizQuestion(
            id: "science-01",
            category: .scienceAndTechnology,
            text: "Which planet is closest to the Sun?",
            options: [
                "Earth",
                "Venus",
                "Mars",
                "Mercury"
            ],
            correctAnswerIndex: 3,
            explanation: "Mercury has the closest orbit to the Sun."
        ),

        QuizQuestion(
            id: "science-02",
            category: .scienceAndTechnology,
            text: "What is the chemical formula for water?",
            options: [
                "H2O",
                "CO2",
                "O2",
                "NaCl"
            ],
            correctAnswerIndex: 0,
            explanation: "A water molecule contains two hydrogen atoms and one oxygen atom."
        ),

        QuizQuestion(
            id: "science-03",
            category: .scienceAndTechnology,
            text: "Which part of a plant mainly absorbs water from the soil?",
            options: [
                "Flowers",
                "Leaves",
                "Roots",
                "Fruit"
            ],
            correctAnswerIndex: 2,
            explanation: "Roots absorb water and dissolved minerals from the soil."
        ),

        QuizQuestion(
            id: "science-04",
            category: .scienceAndTechnology,
            text: "What does CPU stand for?",
            options: [
                "Computer Power Utility",
                "Central Processing Unit",
                "Control Program User",
                "Central Printing Unit"
            ],
            correctAnswerIndex: 1,
            explanation: "The Central Processing Unit executes program instructions."
        ),

        QuizQuestion(
            id: "science-05",
            category: .scienceAndTechnology,
            text: "Which two digits are used in the binary number system?",
            options: [
                "1 and 2",
                "0 and 9",
                "2 and 8",
                "0 and 1"
            ],
            correctAnswerIndex: 3,
            explanation: "Binary is a base-two number system using only 0 and 1."
        ),

        QuizQuestion(
            id: "science-06",
            category: .scienceAndTechnology,
            text: "Which force keeps planets in orbit around the Sun?",
            options: [
                "Gravity",
                "Friction",
                "Buoyancy",
                "Air resistance"
            ],
            correctAnswerIndex: 0,
            explanation: "Gravity attracts planets towards the Sun and curves their paths into orbits."
        ),

        QuizQuestion(
            id: "science-07",
            category: .scienceAndTechnology,
            text: "Which organ pumps blood around the human body?",
            options: [
                "Liver",
                "Lung",
                "Heart",
                "Stomach"
            ],
            correctAnswerIndex: 2,
            explanation: "The heart pumps blood through the circulatory system."
        ),

        QuizQuestion(
            id: "science-08",
            category: .scienceAndTechnology,
            text: "Which unit is used to measure electrical resistance?",
            options: [
                "Volt",
                "Ohm",
                "Watt",
                "Ampere"
            ],
            correctAnswerIndex: 1,
            explanation: "Electrical resistance is measured in ohms."
        ),

        QuizQuestion(
            id: "science-09",
            category: .scienceAndTechnology,
            text: "Which material is usually a good electrical conductor?",
            options: [
                "Rubber",
                "Glass",
                "Dry wood",
                "Copper"
            ],
            correctAnswerIndex: 3,
            explanation: "Copper conducts electricity well and is widely used in electrical wiring."
        ),

        QuizQuestion(
            id: "science-10",
            category: .scienceAndTechnology,
            text: "What is the process of a liquid turning into a gas called?",
            options: [
                "Vaporization",
                "Freezing",
                "Condensation",
                "Melting"
            ],
            correctAnswerIndex: 0,
            explanation: "Vaporization changes a liquid into a gas; evaporation and boiling are examples."
        )
    ]

    static func questions(
        for category: QuizCategory
    ) -> [QuizQuestion] {
        all.filter { $0.category == category }
    }
}