//
//  LibraryBook.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//

import Foundation


// Definição do tipo "LibraryBook" com as propriedades descritas.
struct LibraryBook: Identifiable {
    let id: Int
    let title: String
    let author: String
    let category: String
    let synopsis: String
    let symbol: String
    let publisher: String
    let releaseDate: String
    let pages: Int
    let isbn: String
    let imageName: String
}

// extension permite acrescentar funcionalidades a um tipo ja definido.
extension LibraryBook {
    // o static define que "samples" pertence ao tipo LibraryBook.
    static let samples: [LibraryBook] = [
        LibraryBook(
            id: 1,
            title: "Design do objeto",
            author: "João Gomes Filho",
            category: "Design e arquitetura",
            synopsis: """
            O livro apresenta os fundamentos do desenvolvimento de produtos e do design, abordando a relação usuário-produto, níveis de complexidade e funções prática, estética e simbólica, além de detalhar dez bases conceituais do design do objeto com análises e exemplos, estimulando a reflexão crítica sobre o impacto dos objetos no cotidiano, no consumo e no meio ambiente.
            """,
            symbol: "text.book.closed.fill",
            publisher: "Senac São Paulo",
            releaseDate: "26/05/2026",
            pages: 270,
            isbn: "9788539659814",
            imageName: "senacBook"
        )
    ]
}

