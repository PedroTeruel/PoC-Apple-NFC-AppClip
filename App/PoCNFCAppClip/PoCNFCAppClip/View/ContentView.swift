//
//  ContentView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 27/10/26.
//


import SwiftUI

struct ContentView: View {
    @State private var library = Library()
    @State private var selectedTab: LibraryTab = .books

    @StateObject private var nfcManager = NFCManager()

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(
                "Locações",
                systemImage: "books.vertical",
                value: LibraryTab.loans
            ) {
                Color.clear
            }
            Tab(
                "Livros",
                systemImage: "book.closed",
                value: LibraryTab.books
            ) {
                NavigationStack {
                    BooksView()
//                        .toolbar {
//                            ToolbarItem(placement: .topBarTrailing) {
//                                Button {
//                                    nfcManager.startReading()
//                                } label: {
//                                    Label(
//                                        "Escanear livro",
//                                        systemImage: "wave.3.right"
//                                    )
//                                }
//                            }
//                        }
//                        .safeAreaInset(edge: .bottom) {
//                            if nfcManager.contentRead != "Nenhum livro identificado" {
//                                Text(nfcManager.contentRead)
//                                    .font(.footnote)
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
//                                    .background(.regularMaterial)
//                            }
//                        }
                }
            }
            Tab(
                "Perfil",
                systemImage: "person.crop.circle",
                value: LibraryTab.profile
            ) {
                Color.clear
            }
        }
        .environment(library)
    }
}

private enum LibraryTab: Hashable {
    case loans
    case books
    case profile
}


#Preview {
    ContentView()
}
