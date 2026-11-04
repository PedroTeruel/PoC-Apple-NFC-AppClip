//
//  RentalFormView.swift
//  PoCNFCAppClip
//
//  Created by Mariana Fracaroli Lopes on 03/11/26.
//

import SwiftUI

struct RentalFormView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var fullName = ""
    @State private var studentCode = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var course = ""

    var body: some View {
        VStack(spacing: 0) {

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 19, weight: .medium))
                            .foregroundStyle(.black)
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular, in: Circle())
                    }
                    .padding(.bottom, 24)

                    Text("Seus dados")
                        .font(.system(size: 30, weight: .bold, design: .serif))
                        .foregroundStyle(.black)

                    Text("Informe seus dados para registrar o empréstimo do livro.")
                        .font(.system(size: 18))
                        .foregroundStyle(.secondary)
                        .padding(.top, 6)

                    VStack(spacing: 38) {

                        formField(
                            title: "Nome completo",
                            placeholder: "Ex: Júlia Silva",
                            text: $fullName
                        )

                        formField(
                            title: "Código de aluno",
                            placeholder: "Ex: 1012018010",
                            text: $studentCode,
                            keyboard: .numberPad
                        )

                        formField(
                            title: "E-mail institucional",
                            placeholder: "Ex: julia.silva@senacsp.edu.br",
                            text: $email,
                            keyboard: .emailAddress
                        )

                        formField(
                            title: "Telefone",
                            placeholder: "Ex: (11) 99999-9999",
                            text: $phone,
                            keyboard: .phonePad
                        )

                        formField(
                            title: "Curso",
                            placeholder: "Ex: Engenharia de Software",
                            text: $course
                        )
                    }
                    .padding(.top, 62)
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 28)
                .padding(.top, 12)
            }

            // botão só visual, depois eu arrumo a função
            Text("Confirmar empréstimo")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color("primaryLibrary"), in: Capsule())
                .shadow(color: .black.opacity(0.18), radius: 7, x: 0, y: 4)
                .padding(.horizontal, 32)
                .padding(.top, 12)
                .padding(.bottom, 20)
        }
        .background(Color.white)
        .toolbar(.hidden, for: .navigationBar)
    }

    // função reutilizável dos placeholders, tenho q criar um arquivo pra ele depois, mas o vini vai
    // arrumar ainda entao to esperando ele
    private func formField(
        title: String,
        placeholder: String,
        text: Binding<String>,
        keyboard: UIKeyboardType = .default) -> some View {

        VStack(alignment: .leading, spacing: 10) {

            HStack(alignment: .center) {
                HStack(spacing: 2) {
                    Text(title)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black)

                    Text("*")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.red)
                }

                Spacer()

                Text("campo obrigatório")
                    .font(.system(size: 14))
                    .foregroundStyle(.red)
            }

            TextField(
                "",
                text: text,
                prompt: Text(placeholder)
                    .foregroundStyle(Color.gray.opacity(0.45))
            )
            .font(.system(size: 19))
            .keyboardType(keyboard)
            .textInputAutocapitalization(
                keyboard == .emailAddress ? .never : .sentences
            )
            .autocorrectionDisabled()
            .padding(.vertical, 10)

            Rectangle()
                .fill(Color.gray.opacity(0.22))
                .frame(height: 1)
        }
    }
}

#Preview {
    NavigationStack {
        RentalFormView()
    }
}

