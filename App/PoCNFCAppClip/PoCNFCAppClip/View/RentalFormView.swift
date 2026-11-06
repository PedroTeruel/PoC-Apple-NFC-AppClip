//
//  RentalFormView.swift
//  PoCNFCAppClip
//
//  Created by Mariana Fracaroli Lopes on 03/11/26.
//


import SwiftUI

struct RentalFormView: View {
    
    var onConfirm: () -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var viewModel = RentalFormViewModel()

    var body: some View  {
        VStack(spacing: 0) {

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 21, weight: .medium))
                        .foregroundStyle(.primary)
                        .frame(width: 44, height: 44)
                        .glassEffect(.regular, in: Circle())
                }
                .buttonStyle(.plain)

                Spacer()

                Text("Empréstimo")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.primary)

                Spacer()

                Button {
                    guard viewModel.isFormValid else { return }

                    onConfirm()
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 23, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(Color("primaryLibrary"), in: Circle())
                }
                .buttonStyle(.plain)
                .disabled(!viewModel.isFormValid)
                .opacity(viewModel.isFormValid ? 1 : 0.5)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 36)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    Text("Informe seus dados para registrar o empréstimo do livro.")
                        .font(.system(size: 16))
                        .foregroundStyle(.secondary)
                        .lineSpacing(4)

                   VStack(spacing: 30) {
                        
                        RentalFormField(
                            title: "Nome completo",
                            placeholder: "Ex: Júlia Silva",
                            text: $viewModel.fullName
                        )

                        RentalFormField(
                            title: "Código de aluno",
                            placeholder: "Ex: 1012018010",
                            text: $viewModel.studentCode,
                            keyboard: .numberPad
                        )

                        RentalFormField(
                            title: "E-mail institucional",
                            placeholder: "Ex: julia.silva@senacsp.edu.br",
                            text: $viewModel.email,
                            keyboard: .emailAddress
                        )

                        RentalFormField(
                            title: "Telefone",
                            placeholder: "Ex: (11) 99999-9999",
                            text: $viewModel.phone,
                            keyboard: .phonePad
                        )

                        RentalFormField(
                            title: "Curso",
                            placeholder: "Ex: Engenharia de Software",
                            text: $viewModel.course
                        )
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 30)
                    .padding(.top, 26)
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 24)
            }
        }
        .background(Color.white)
    }

}

#Preview {
    RentalFormView {
        print("Empréstimo confirmado")
    }
    .presentationDetents([.large])
    .presentationCornerRadius(32)
}
