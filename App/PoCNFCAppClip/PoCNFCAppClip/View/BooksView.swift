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
    @State private var scannedBook: LibraryBook?
    @State private var rentedBookIDs: Set<LibraryBook.ID> = []
    @State private var showUnknownBookAlert = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {

                Image("senacLibrary")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 24) {

                    ButtonNextLibrary(onScan: nfcManager.startReading)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Aproxime seu iPhone da etiqueta NFC do livro para acessar a área de reserva.")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.black.opacity(0.85))
                            .lineSpacing(5)

                        Text(nfcManager.contentRead)
                            .font(.footnote)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
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

            .navigationDestination(item: $scannedBook) { book in
                BookDetailView(book: book, rentedBookIDs: $rentedBookIDs)
            }

            .onChange(of: nfcManager.scannedCode) { _, newCode in
                guard let code = newCode else {
                    return
                }

                if let book = bookForTag(code) {
                    scannedBook = book
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

    private func bookForTag(_ code: String) -> LibraryBook? {
        let mapping: [String: Int] = [
            "LIVRO-001": 1,
            "LIVRO-002": 2,
            "LIVRO-003": 3
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
