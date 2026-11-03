//
//  LibraryBook.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//

import Foundation

struct LibraryBook: Identifiable {
    let id: Int
    let title: String
    let author: String
    let category: String
    let synopsis: String
    let symbol: String
}

extension LibraryBook {
    static let samples: [LibraryBook] = [
        LibraryBook(
            id: 1,
            title: "Arquitetura de Sistemas Para Web com Java",
            author: "Evandro C. Teruel",
            category: "Computação",
            synopsis: "Esse livro apresenta os principais design patterns e frameworks utilizados no desenvolvimento de aplicações web na plataforma Java.",
            symbol: "chevron.left.forwardslash.chevron.right"
        ),
        LibraryBook(
            id: 2,
            title: "A Divina Comédia",
            author: "Dante Alighieri",
            category: "Literatura",
            synopsis: "Texto fundador da língua italiana, súmula da cosmovisão de toda uma época, monumento poético de rigor e beleza, obra magna da literatura universal.",
            symbol: "text.book.closed.fill"
        ),
        LibraryBook(
            id: 3,
            title: "A revolução dos bichos",
            author: "George Orwell",
            category: "Literatura",
            synopsis: "Em plena Segunda Guerra Mundial, publicada em 1945 depois de ter sido rejeitada por várias editoras, essa pequena narrativa causou desconforto ao satirizar ferozmente a DITADURA STALINISTA",
            symbol: "text.book.closed.fill"
        )
    ]
}
