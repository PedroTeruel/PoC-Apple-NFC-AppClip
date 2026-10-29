//
//  BooksView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//
import SwiftUI

struct BooksView: View {
    @Environment(Library.self) private var library
    @State private var showScanner = false
    
    @StateObject private var nfcManager = NFCManager()
    
    @State private var scannedBookID: LibraryBook.ID?
    @State private var showUnknownBookAlert = false

    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    Button {
                        nfcManager.startReading()
                    } label: {
                        Text("Escanear")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    .buttonStyle(.borderedProminent)

//                    Text(nfcManager.contentRead)
//                        .font(.footnote)
//                        .foregroundStyle(.secondary)
//                        .multilineTextAlignment(.center)
                }
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
                                if library.isRented(book: book) {
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
        .onChange(of: nfcManager.scannedCode) { _, code in
            guard let code else { return }

            if let book = bookForTag(code) {
                scannedBookID = book.id
            } else {
                showUnknownBookAlert = true
            }
        }
        .navigationDestination(item: $scannedBookID) { id in
            if let book = library.books.first(where: { $0.id == id }) {
                BookDetailView(book: book)
            } else {
                ContentUnavailableView(
                    "Livro não encontrado",
                    systemImage: "book.closed"
                )
            }
        }
        .alert("Livro não encontrado", isPresented: $showUnknownBookAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Esta etiqueta NFC não está associada a um livro do catálogo.")
        }

//        .sheet(isPresented: $showScanner) {
//            ScanSheetView()
//                .presentationDetents([.medium])
//                .presentationDragIndicator(.visible)
//        }
    }
    
    private func bookForTag(_ code: String) -> LibraryBook? {
        let mapping: [String: String] = [
            "LIVRO-001": "Arquitetura de Sistemas Para Web com Java",
            "LIVRO-002": "A Divina Comédia"
        ]

        guard let title = mapping[code] else {
            return nil
        }

        return library.books.first { $0.title == title }
    }
    
}

#Preview {
    NavigationStack {
        BooksView()
    }
    .environment(Library())
}
