import SwiftUI

struct BookDetailView: View {
    @Environment(Library.self) private var library
    let book: LibraryBook
    @State private var showRentalSuccess = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: book.symbol)
                    .font(.system(size: 64))
                    .foregroundStyle(.tint)
                    .frame(maxWidth: .infinity, minHeight: 180)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 16))
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 8) {
                    Text(book.title)
                        .font(.title.bold())
                    Text(book.author)
                        .foregroundStyle(.secondary)
                    Text(book.category)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Sinopse")
                        .font(.headline)
                    Text(book.synopsis)
                }

                if book.copies == 0 {
                    Label("Livro indisponível", systemImage: "xmark.circle")
                        .foregroundStyle(.secondary)
                }

                Button {
                    library.rent(book)
                    showRentalSuccess = true
                } label: {
                    Text(library.isRented(book) ? "Alugado por você" : "Alugar livro")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                .buttonStyle(.borderedProminent)
                .disabled(book.copies == 0 || library.isRented(book))
            }
            .padding()
        }
        .navigationTitle("Detalhes do livro")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Livro alugado!", isPresented: $showRentalSuccess) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Você alugou \(book.title).")
        }
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: LibraryBook.samples[0])
    }
    .environment(Library())
}
