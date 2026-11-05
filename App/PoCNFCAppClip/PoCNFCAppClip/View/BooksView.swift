//
//  BooksView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//

import SwiftUI

struct BooksView: View {

    private let books = LibraryBook.samples

    @StateObject private var nfcManager = NFCManager()
    @State private var scannedBookID: Int?
    @State private var showUnknownBookAlert = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {

                Image("senacSportCourt")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Text("Aproxime seu iPhone da etiqueta NFC do livro para acessar a área de reserva.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black.opacity(0.85))
                        .lineSpacing(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ButtonNext()
                    
                    
                }
                .padding(.horizontal, 30)
                .padding(.top, 40)
                .padding(.bottom, 50)
                .frame(maxWidth: .infinity)
                .background {
                    UnevenRoundedRectangle(
                        topLeadingRadius: 30,
                        topTrailingRadius: 30
                    )
                    .fill(.ultraThinMaterial)
                    .overlay {
                        UnevenRoundedRectangle(
                            topLeadingRadius: 30,
                            topTrailingRadius: 30
                        )
                        .fill(Color.white.opacity(0.45))
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
            }

            .navigationDestination(item: $scannedBookID) { bookID in
                if let book = books.first(where: { $0.id == bookID }) {
                    BookDetailView(book: book)
                } else {
                    ContentUnavailableView(
                        "Livro não encontrado",
                        systemImage: "book.closed"
                    )
                }
            }

            .onChange(of: nfcManager.scannedCode) { _, newCode in
                guard let code = newCode else {
                    return
                }

                if let book = bookForTag(code) {
                    scannedBookID = book.id
                } else {
                    showUnknownBookAlert = true
                }
            }

            .alert(
                "Livro não encontrado",
                isPresented: $showUnknownBookAlert
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Não encontramos um livro associado a esta tag NFC.")
            }
        }
    }
    
    // função para realizar a associação das tags com os devidos livros.
    // exemplo: a tag que manda "LIVRO-001" abre a BookDetailView com as informaçoes do livro com id: 1

    private func bookForTag(_ code: String) -> LibraryBook? {
        let mapping: [String: Int] = [
            "LIVRO-001": 1
        ]

        guard let id = mapping[code] else{
            return nil
        }

        return books.first{
            $0.id == id
        }
    }

}

#Preview {
    BooksView()
}
