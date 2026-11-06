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
    @State private var goToReserva = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {

                Image("senacSportCourt")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
            
                VStack(spacing: 0) {
                    Button {
                        nfcManager.startReading()
                    } label: {
                        HStack {
                            Text("Fazer Check-in")
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(.ultraThinMaterial, in: Capsule())
                        .overlay(
                            Capsule()
                                .stroke(.white.opacity(0.3), lineWidth: 1)
                        )
                        .shadow(
                            color: .black.opacity(0.10),
                            radius: 8,
                            x: 0,
                            y: 4
                        )
                    }
                    .buttonStyle(.plain)
                    
                    Text("Aproxime seu Iphone da etiqueta NFC da quadra para efetuar seu check-in.")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(.black.opacity(0.85))
                        .lineSpacing(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 27)
                        .padding(.top, 13)
                    
                    
                    Button {
                        goToReserva = true
                    } label: {
                        HStack {
                            Text("Efetuar uma reserva")
                                .font(.body)
                                .fontWeight(.medium)
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            Color("primarySportC"),
                            in: Capsule()
                        )
                        .shadow(
                            color: .black.opacity(0.20),
                            radius: 10,
                            x: 0,
                            y: 6
                        )
                    }
                    .navigationDestination(isPresented: $goToReserva){
                        ReservadequadrasView()
                    }
                    .buttonStyle(.plain)
                    
                    
                    
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
