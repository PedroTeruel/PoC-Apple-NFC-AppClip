//
//  BookDetailView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//


import SwiftUI

struct BookDetailView: View {
    @Environment(Library.self) private var library
    @Environment(\.dismiss) private var dismiss

    let book: LibraryBook
    @State private var showRentalSuccess = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                ZStack {
                    Color("backgroundLibrary")

                    Image("senacBook")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 195, height: 280)
                }
                .frame(height: 390)
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 0) {

                    Text(book.title)
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .foregroundStyle(Color("primaryLibrary"))

                    Text(book.author)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.secondary)
                        .padding(.top, 3)

                    Divider()
                        .padding(.vertical, 18)

                    Text(book.synopsis)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.secondary)
                        .lineSpacing(4)

                    Divider()
                        .padding(.vertical, 22)

                    VStack(spacing: 27) {
                        infoRow(title: "Editora", value: "Senac São Paulo")
                        infoRow(title: "Data de lançamento", value: "26/05/2026")
                        infoRow(title: "Páginas", value: "270")
                        infoRow(title: "Categoria", value: "Design e arquitetura")
                        infoRow(title: "ISBN", value: "9788539659814")
                    }

                    Button {
                        library.rent(book: book)
                        showRentalSuccess = true
                    } label: {
                        Text(library.isRented(book: book) ? "Alugado por você" : "Solicitar empréstimo")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color("primaryLibrary"), in: Capsule())
                        .shadow(color: .black.opacity(0.18),radius: 6,x: 0,y: 4)
                    }
                    .disabled(library.isRented(book: book))
                    .padding(.top, 28)
                    .padding(.bottom, 24)
                }
                .padding(.horizontal, 22)
                .padding(.top, 22)
                .background(Color("secondaryLibrary"))
            }
        }
        .background(Color("backgroundLibrary"))

        .toolbar(.hidden, for: .navigationBar)

        .safeAreaInset(edge: .top, spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .font(.system(size: 19, weight: .medium))
                        .frame(width: 44, height: 44)
                        .glassEffect(.regular, in: Circle())
                        .contentShape(Circle())
                }

                Spacer()

                Text("Detalhes")
                    .font(.system(size: 20, weight: .bold, design: .serif))
                    .foregroundStyle(.black)

                Spacer()

                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 8)
            .background(Color("backgroundLibrary"))
        }
        .alert("Empréstimo solicitado!", isPresented: $showRentalSuccess) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Você solicitou o empréstimo de \(book.title).")
        }
    }

    private func infoRow(title: String, value: String) -> some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: LibraryBook.samples[0])
    }
    .environment(Library())
}
