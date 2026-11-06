//
//  ReservadequadrasView.swift
//  PoCNFCAppClip
//
//  Created by Vinicius de Brito on 06/11/26.
//

import SwiftUI

struct ReservadequadrasView: View {
   
        private let books = LibraryBook.samples

        @StateObject private var nfcManager = NFCManager()
        @State private var scannedBookID: Int?
        @State private var showUnknownBookAlert = false
    @State private var quadraSelecionada = "Quadra 1"
    @State private var dataReserva = Date()
    @State private var horarioInicio = Date()
    @State private var horarioFim = Date()
    @State private var nome: String = ""
    @State private var cpf: String = ""
    @State private var curso: String = ""

    let quadras = ["Quadra 1", "Quadra 2", "Quadra 3"]
    
    

        var body: some View {
            NavigationStack {
                ZStack(alignment: .bottom) {

                    Image("senacSportCourt")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    
                    
                
                    VStack(spacing: 22) {
                       
                        
                            Text("Reserva de quadras")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundStyle(.black.opacity(0.85))
                                .lineSpacing(5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, -2)
                            
                            
                            
                            VStack(alignment: .leading, spacing: 8) {
                                // Título da Seção
                                Text("Descreva sua reserva")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .padding(.leading, 8)
                                
                                // Container do Menu
                                VStack(spacing: 0) {
                                    // Linha 1: Selecionar Quadra
                                    HStack {
                                        Text("Selecione a quadra")
                                            .font(.body)
                                            .foregroundStyle(.primary)
                                        
                                        Spacer()
                                        
                                        Picker("", selection: $quadraSelecionada) {
                                            ForEach(quadras, id: \.self) { quadra in
                                                Text(quadra).tag(quadra)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .tint(.secondary)
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(height: 54)
                                    
                                    Divider()
                                        .padding(.leading, 16)
                                    
                                    // Linha 2: Dia da reserva
                                    HStack {
                                        Text("Dia da reserva")
                                            .font(.body)
                                            .foregroundStyle(.primary)
                                        
                                        Spacer()
                                        
                                        DatePicker("", selection: $dataReserva, displayedComponents: .date)
                                            .labelsHidden()
                                            .datePickerStyle(.compact)
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(height: 54)
                                    
                                    Divider()
                                        .padding(.leading, 16)
                                    
                                    // Linha 3: Horário da reserva
                                    HStack {
                                        Text("Horário da reserva")
                                            .font(.body)
                                            .foregroundStyle(.primary)
                                        
                                        Spacer()
                                        
                                        DatePicker("", selection: $horarioInicio, displayedComponents: .hourAndMinute)
                                            .labelsHidden()
                                            .datePickerStyle(.compact)
                                        
                                        DatePicker("", selection: $horarioFim, displayedComponents: .hourAndMinute)
                                            .labelsHidden()
                                            .datePickerStyle(.compact)
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(height: 54)
                                }
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                            }
                            .padding(.horizontal, -10)
                            
                            
                            
                            
                            VStack(alignment: .leading, spacing: 8) {
                                // Título da Secção
                                Text("Identificação")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .padding(.leading, 8)
                                
                                // Container do Menu
                                VStack(spacing: 0) {
                                    // Linha 1: Nome
                                    TextField("Escreva seu nome aqui", text: $nome)
                                        .font(.body)
                                        .padding(.horizontal, 16)
                                        .frame(height: 54)
                                    
                                    Divider()
                                        .padding(.leading, 16)
                                    
                                    // Linha 2: CPF
                                    TextField("Escreva seu CPF aqui", text: $cpf)
                                        .font(.body)
                                        .keyboardType(.numberPad) // Abre o teclado numérico
                                        .padding(.horizontal, 16)
                                        .frame(height: 54)
                                    
                                    Divider()
                                        .padding(.leading, 16)
                                    
                                    // Linha 3: Curso
                                    TextField("Escreva seu curso aqui", text: $curso)
                                        .font(.body)
                                        .padding(.horizontal, 16)
                                        .frame(height: 54)
                                }
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                            }
                            .padding(.horizontal, -10)
                            
                            
                            
                            
                            
                            Button {
                                
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
                            .padding(.horizontal, -10)
                            .buttonStyle(.plain)
                            
                        
                        
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40)
                    .padding(.bottom, 40)
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
    ReservadequadrasView()
}
