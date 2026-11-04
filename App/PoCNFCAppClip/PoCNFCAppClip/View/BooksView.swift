//
//  BooksView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//


import SwiftUI

struct BooksView: View {

    @Environment(Library.self) private var library
    @StateObject private var nfcManager = NFCManager()

    @State private var scannedBookID: LibraryBook.ID?
    @State private var showUnknownBookAlert = false

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("senacLibrary")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width,height: geometry.size.height)
                    .clipped()
            }
            .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 16) {

                    Text("Aproxime seu iPhone da etiqueta NFC do livro para acessar a área de reserva.")
                        .font(.system(size: 15))
                        .foregroundStyle(.primary)

                    Button {
                        nfcManager.startReading()
                    } label: {

                        HStack(spacing: 12) {

                            Image(systemName: "wave.3.right")
                                .font(.title2)

                            Text("Escanear livro")
                                .font(.system(size: 16, weight: .semibold))

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.headline)
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color("primaryLibrary"),in: Capsule())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 8)
                .background {
                    UnevenRoundedRectangle(topLeadingRadius: 20,bottomLeadingRadius: 0,bottomTrailingRadius: 0,topTrailingRadius: 20)
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea(edges: .bottom)
                }
            }
        }
        .onChange(of: nfcManager.scannedCode) { _, code in
            guard let code else{
                return
            }

            if let book = bookForTag(code){
                scannedBookID = book.id
            } else{
                showUnknownBookAlert = true
            }
        }
        .navigationDestination(item: $scannedBookID) { bookID in
            if let book = library.books.first(where: { $0.id == bookID }){
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
            Text("Essa etiqueta NFC não está associada ao livro da demonstração.")
        }
    }

    private func bookForTag(_ code: String) -> LibraryBook? {
        guard code == "LIVRO-001" else {
            return nil
        }

        return library.books.first
    }
}

#Preview {
    NavigationStack {
        BooksView()
    }
    .environment(Library())
}
