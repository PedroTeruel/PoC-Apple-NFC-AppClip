import Testing
@testable import PoCNFCAppClip

@MainActor
struct PoCNFCAppClipTests {
    @Test func rentalIsSharedAndDoesNotDuplicate() {
        let library = Library()
        let book = library.books[0]
        #expect(!library.isRented(book))
        library.rent(book)
        library.rent(book)
        #expect(library.isRented(book))
        #expect(library.rentedBookIDs.count == 1)
    }

    @Test func unavailableBookCannotBeRented() throws {
        let library = Library()
        let book = try #require(library.books.first { $0.copies == 0 })
        library.rent(book)
        #expect(!library.isRented(book))
    }
}
