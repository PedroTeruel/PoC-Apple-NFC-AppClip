//
//  BookDetailView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//


import SwiftUI

struct BookDetailView: View {

    let book: LibraryBook

    @State private var isRented = false
    @State private var showRentalForm = false
    @State private var showRentalSuccess = false

    private let title = "Design do objeto"
    private let author = "João Gomes Filho"

    private let synopsis = """
    O livro apresenta os fundamentos do desenvolvimento de produtos e do design, abordando a relação usuário-produto, níveis de complexidade e funções prática, estética e simbólica, além de detalhar dez bases conceituais do design do objeto com análises e exemplos, estimulando a reflexão crítica sobre o impacto dos objetos no cotidiano, no consumo e no meio ambiente.
    """

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(spacing: 0) {

                ZStack {
                    Color("backgroundLibrary")

                    Image(book.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 195, height: 280)
                }
                .frame(height: 390)
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 0) {

                    Text(book.title)
                        .font(.system(
                            size: 24,
                            weight: .bold,
                            design: .serif
                        ))
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

                        BookInfoRow(
                            title: "Editora",
                            value: book.publisher
                        )

                        BookInfoRow(
                            title: "Data de lançamento",
                            value: book.releaseDate
                        )

                        BookInfoRow(
                            title: "Páginas",
                            value: "\(book.pages)"
                        )

                        BookInfoRow(
                            title: "Categoria",
                            value: book.category
                        )

                        BookInfoRow(
                            title: "ISBN",
                            value: book.isbn
                        )
                    }

                    Button {
                       // showRentalForm = true
                        showRentalSuccess = true
                    } label: {

                        Text(
                            isRented
                            ? "Alugado por você"
                            : "Solicitar empréstimo"
                        )
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            Color("primaryLibrary"),
                            in: Capsule()
                        )
                        .shadow(
                            color: .black.opacity(0.18),
                            radius: 6,
                            x: 0,
                            y: 4
                        )
                    }
                    .disabled(isRented)
                    .padding(.top, 28)
                    .padding(.bottom, 24)
                }
                .padding(.horizontal, 22)
                .padding(.top, 22)
                .background(Color.white)
            }
        }
        .background(Color("backgroundLibrary"))

        .toolbar(.hidden, for: .navigationBar)

        .safeAreaInset(edge: .top, spacing: 0) {

            HStack {

                BackButton()

                Spacer()

                Text("Detalhes")
                    .font(.system(
                        size: 20,
                        weight: .bold,
                        design: .serif
                    ))
                    .foregroundStyle(.black)

                Spacer()

                Color.clear
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 8)
            .background(Color("backgroundLibrary"))
        }

//        .alert(
//            "Empréstimo confirmado!",
//            isPresented: $showRentalSuccess
//        ) {
//            Button("OK", role: .cancel) {}
//        } message: {
//            Text("Você solicitou o empréstimo de \(book.title).")
//        }
        .alert("Empréstimo confirmado!", isPresented: $showRentalSuccess) {
            Button("Entendi") {
            }
            .keyboardShortcut(.defaultAction)
        } message: {
            Text("Você solicitou o empréstimo de \(book.title).")
        }

//        .sheet(
//            isPresented: $showRentalForm,
//            onDismiss: {
//                if isRented {
//                    showRentalSuccess = true
//                }
//            }
//        ) {
//            RentalFormView {
//
//                isRented = true
//                showRentalForm = false
//
//            }
//            .presentationDetents([.large])
//            .presentationDragIndicator(.hidden)
//            .presentationCornerRadius(32)
//            .presentationBackground(.white)
//        }
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: LibraryBook.samples[0])
    }
}
