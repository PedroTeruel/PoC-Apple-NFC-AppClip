import SwiftUI

struct BooksView: View {
    @Environment(Library.self) private var library
    @State private var showScanner = false

    var body: some View {
        List {
            Section {
                Button {
                    showScanner = true
                } label: {
                    Text("Escanear")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                .buttonStyle(.borderedProminent)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }

            Section("Livros") {
                ForEach(library.books) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: book.symbol)
                                .font(.title2)
                                .foregroundStyle(.tint)
                                .frame(width: 48, height: 64)
                                .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                                .accessibilityHidden(true)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                if library.isRented(book) {
                                    Text("Alugado por você")
                                        .font(.caption)
                                        .foregroundStyle(.tint)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .accessibilityIdentifier("book-\(book.id)")
                }
            }
        }
        .navigationTitle("Biblioteca")
        .sheet(isPresented: $showScanner) {
            ScanSheetView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    NavigationStack {
        BooksView()
    }
    .environment(Library())
}
