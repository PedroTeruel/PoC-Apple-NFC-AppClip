import Foundation

struct LibraryBook: Identifiable {
    let id: Int
    let title: String
    let author: String
    let category: String
    let synopsis: String
    let copies: Int
    let symbol: String
}

extension LibraryBook {
    static let samples: [LibraryBook] = [
        LibraryBook(
            id: 1,
            title: "Clean Code",
            author: "Robert C. Martin",
            category: "Computação",
            synopsis: "Uma introdução a princípios e práticas para escrever código mais legível, organizado e sustentável.",
            copies: 3,
            symbol: "chevron.left.forwardslash.chevron.right"
        ),
        LibraryBook(
            id: 2,
            title: "O Design do Dia a Dia",
            author: "Don Norman",
            category: "Design",
            synopsis: "Uma exploração de como objetos e interfaces podem ser projetados para facilitar a compreensão e o uso.",
            copies: 2,
            symbol: "paintbrush.pointed.fill"
        ),
        LibraryBook(
            id: 3,
            title: "Dom Casmurro",
            author: "Machado de Assis",
            category: "Literatura",
            synopsis: "Bentinho relembra sua juventude, seu relacionamento com Capitu e acontecimentos que marcaram sua vida.",
            copies: 4,
            symbol: "text.book.closed.fill"
        ),
        LibraryBook(
            id: 4,
            title: "Algoritmos: Teoria e Prática",
            author: "Thomas H. Cormen",
            category: "Computação",
            synopsis: "Uma referência acadêmica sobre estruturas de dados, análise de algoritmos e técnicas de resolução de problemas.",
            copies: 0,
            symbol: "curlybraces"
        ),
        LibraryBook(
            id: 5,
            title: "1984",
            author: "George Orwell",
            category: "Literatura",
            synopsis: "Uma narrativa distópica sobre vigilância, controle da informação e liberdade individual.",
            copies: 2,
            symbol: "eye.fill"
        ),
        LibraryBook(
            id: 6,
            title: "Design Patterns",
            author: "Erich Gamma e outros",
            category: "Engenharia de Software",
            synopsis: "Uma apresentação de padrões reutilizáveis para organizar soluções em projetos de software orientados a objetos.",
            copies: 2,
            symbol: "square.stack.3d.up.fill"
        )
    ]
}
