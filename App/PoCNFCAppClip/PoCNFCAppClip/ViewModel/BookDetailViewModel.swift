//
//  BookDetailViewModel.swift
//  PoCNFCAppClip
//
//  Created by Mariana Fracaroli Lopes on 04/11/26.
//

import SwiftUI

@Observable
class BookDetailViewModel {

    var showRentalSuccess = false

    func rentBook(_ book: LibraryBook, using library: Library) {
        library.rent(book: book)
        showRentalSuccess = true
    }
}
