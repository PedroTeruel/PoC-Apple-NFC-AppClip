//
//  Library.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//

import Observation

@MainActor
@Observable

class Library {
    let books = LibraryBook.samples
    
    var rentedBookIDs: Set<LibraryBook.ID> = []

    func isRented(book: LibraryBook) -> Bool {
        rentedBookIDs.contains(book.id)
    }

    func rent(book: LibraryBook) {
        rentedBookIDs.insert(book.id)
    }
}
