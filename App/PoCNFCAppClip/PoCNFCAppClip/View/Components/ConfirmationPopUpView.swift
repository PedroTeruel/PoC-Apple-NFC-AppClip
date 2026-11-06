//
//  Pop-upReservaconfirmada.swift
//  PoCNFCAppClip
//
//  Created by Vinicius de Brito on 06/11/26.
//

import SwiftUI

struct ConfirmationPopUpView: View {
    var onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            // Mensagem do PopUp
            Text("Reserva criada com sucesso!")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
            
            // Botão de Confirmação
            Button {
                onConfirm()
            } label: {
                Text("Confirmar")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        Color("primarySportC"),
                        in: Capsule()
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 28)
        .frame(maxWidth: 320)
        // MARK: - Liquid Glass
        .background(
            ZStack {
                // 1. Desfoque de refração nativo
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(.ultraThinMaterial)
                
                // 2. Brilho especular do vidro (gradiente de luz)
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.40),
                                Color.white.opacity(0.08)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
        )
        .overlay(
            // 3. Borda de vidro com refração pontual
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        stops: [
                            .init(color: .white.opacity(0.9), location: 0.0),
                            .init(color: .white.opacity(0.3), location: 0.4),
                            .init(color: .white.opacity(0.1), location: 0.7),
                            .init(color: .white.opacity(0.6), location: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.2
                )
        )
        // 4. Sombras em camadas para efeito 3D flutuante
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        .shadow(color: Color.black.opacity(0.16), radius: 24, x: 0, y: 14)
    }
}

#Preview {
    ZStack {
        // Fundo simulado para testar o efeito transparente no Canvas do Xcode
        Color.gray.opacity(0.4)
            .ignoresSafeArea()
        
        ConfirmationPopUpView {
            print("Ação acionada no Preview")
        }
    }
}
