//
//  FieldRentView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 05/11/26.
//

import SwiftUI

struct FRView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var selectedF: String?
    @State private var resDate = Date()
    @State private var startTime = Date()
    @State private var endTime = Date().addingTimeInterval(3600)

    @State private var name = ""
    @State private var cpf = ""
    @State private var course = ""

    @State private var isReserved = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    private let green = Color(
        red: 0.28,
        green: 0.49,
        blue: 0.14
    )

    private let fields = [
        "1",
        "2",
        "3"
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image("Biblioteca")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .blur(radius: 12)
                    .overlay(.white.opacity(0.4))
                    .clipped()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: -26) {

                        ZStack {
                            Image("Biblioteca")
                                .resizable()
                                .scaledToFill()

                            LinearGradient(
                                colors: [
                                    green.opacity(0.98),
                                    green.opacity(0.85),
                                    green.opacity(0.15)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )

                            Image("senacLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 190, height: 110)
                                .padding(.bottom, 25)
                        }
                        .frame(maxWidth: .infinity)
                        .clipped()
                            .frame(
                                height: max(
                                    270,
                                    geometry.size.height * 0.37
                                )
                            )

                        VStack(alignment: .leading, spacing: 0) {

                            Text("Titulo")
                                .font(.system(size: 21, weight: .semibold))
                                .foregroundStyle(.primary)

                            Text("Descrição")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                                .padding(.top, 12)

                            VStack(spacing: 0) {

                                Menu {
                                    ForEach(fields, id: \.self) { nomeUn in
                                        Button(nomeUn) {
                                            selectedF = nomeUn
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedF ?? "Selecione")
                                            .foregroundStyle(
                                                selectedF == nil
                                                ? .secondary : .primary
                                            )

                                        Spacer()

                                        Text("O que?")
                                            .font(.system(size: 11))
                                            .foregroundStyle(.secondary)

                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 11, weight: .medium))
                                            .foregroundStyle(.primary)
                                    }
                                    .font(.system(size: 13))
                                    .frame(height: 42)
                                    .contentShape(Rectangle())
                                }

                                Divider()

                                HStack {
                                    Text("Segundo campo")
                                        .font(.system(size: 13))
                                        .foregroundStyle(.secondary)

                                    Spacer(minLength: 4)

                                    DatePicker(
                                        "",
                                        selection: $resDate,
                                        in: Date()...,
                                        displayedComponents: .date
                                    )
                                    .labelsHidden()
                                    .datePickerStyle(.compact)
                                    .tint(green)
                                }
                                .frame(minHeight: 44)

                                Divider()

                                HStack(spacing: 4) {
                                    Text("Terceiro Campo")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.8)

                                    Spacer(minLength: 2)

                                    DatePicker(
                                        "Início",
                                        selection: $startTime,
                                        displayedComponents: .hourAndMinute
                                    )
                                    .labelsHidden()
                                    .datePickerStyle(.compact)
                                    .tint(green)

                                    DatePicker(
                                        "Fim",
                                        selection: $endTime,
                                        displayedComponents: .hourAndMinute
                                    )
                                    .labelsHidden()
                                    .datePickerStyle(.compact)
                                    .tint(green)
                                }
                                .frame(minHeight: 44)
                            }
                            .padding(.horizontal, 13)
                            .background(
                                .white.opacity(0.94),
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                                .padding(.top, 8)

                            Text("Identificação")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                                .padding(.top, 20)

                            VStack(spacing: 0) {

                                TextField(
                                    "Campo",
                                    text: $name
                                )
                                .textContentType(.name)
                                .textInputAutocapitalization(.words)
                                .frame(height: 43)

                                Divider()

                                TextField(
                                    "Campo",
                                    text: $cpf
                                )
                                .keyboardType(.numberPad)
                                .onChange(of: cpf) { _, newValue in
                                    cpf = String(
                                        newValue.filter(\.isNumber).prefix(11)
                                    )
                                }
                                .frame(height: 43)

                                Divider()

                                TextField(
                                    "Campo",
                                    text: $course
                                )
                                .textInputAutocapitalization(.words)
                                .frame(height: 43)
                            }
                            .font(.system(size: 13))
                            .padding(.horizontal, 13)
                            .background(
                                .white.opacity(0.94),
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                                .padding(.top, 8)

                            Button {
                                submitReservation()
                            } label: {
                                Text(
                                    isReserved
                                    ? "Reserva registrada"
                                    : "Efetuar reserva"
                                )
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(green, in: Capsule())
                            }
                            .disabled(isReserved)
                                .padding(.top, 24)
                                .padding(.bottom, 12)
                        }
                        .padding(.horizontal, 18)
                        .padding(.top, 25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background {
                            UnevenRoundedRectangle(
                                topLeadingRadius: 28,
                                topTrailingRadius: 28
                            )
                            .fill(.regularMaterial)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .navigationBar)
        .alert(
            "Reserva de quadra",
            isPresented: $showAlert
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }


//    private var header: some View {
//        
//    }

    // MARK: - Validação

    private func submitReservation() {
        guard selectedF != nil else {
            presentAlert("Selecione uma quadra.")
            return
        }

        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !course.trimmingCharacters(in: .whitespaces).isEmpty,
              cpf.count == 11 else {
            presentAlert(
                "Preencha seu nome, CPF com 11 dígitos e curso."
            )
            return
        }

        let calendar = Calendar.current

        let startMinutes =
            calendar.component(.hour, from: startTime) * 60
            + calendar.component(.minute, from: startTime)

        let endMinutes =
            calendar.component(.hour, from: endTime) * 60
            + calendar.component(.minute, from: endTime)

        guard endMinutes > startMinutes else {
            presentAlert(
                "O horário de término deve ser posterior ao início."
            )
            return
        }

        // Simulação local. Integrar com o backend
        // para efetivamente registrar a reserva.
        isReserved = true

        presentAlert(
            "Reserva registrada neste protótipo. " +
            "A confirmação real depende da integração " +
            "com o sistema de reservas."
        )
    }

    private func presentAlert(_ message: String) {
        alertMessage = message
        showAlert = true
    }
}

//#Preview {
//    NavigationStack {
//        FRView()
//    }
//}

