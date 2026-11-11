//
//  LibraryBook.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//

import Foundation


// Definição do tipo "LibraryBook" com as propriedades descritas.
struct LibraryBook: Identifiable, Hashable {
    let id: Int
    let title: String
    let author: String
    let category: String
    let synopsis: String
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
            title: "Apple Training Series: Mac OS X Support Essentials",
            author: "Owen Linzmayer",
            category: "Sistemas Operacionais",
            synopsis: """
            Trata-se do guia de treinamento oficial da Apple projetado para técnicos de suporte, especialistas de help desk e administradores de sistemas. O manual oferece instruções detalhadas e passo a passo sobre como configurar, otimizar e solucionar problemas no sistema operacional Mac OS X 10.4 (Tiger), abordando desde sistemas de arquivos e permissões até redes, linha de comando e sequências de inicialização.
            """,
            publisher: "Peachpit Press",
            releaseDate: "17/08/2005",
            pages: 547,
            isbn: "9788539659814",
            imageName: "macOS"
        )
    ]
}

