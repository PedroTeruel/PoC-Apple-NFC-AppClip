import Observation

@MainActor
@Observable
final class Library {
    let books = LibraryBook.samples
    private(set) var rentedBookIDs: Set<LibraryBook.ID> = []

    func isRented(_ book: LibraryBook) -> Bool {
        rentedBookIDs.contains(book.id)
    }

    func rent(_ book: LibraryBook) {
        guard book.copies > 0 else { return }
        rentedBookIDs.insert(book.id)
    }
}
