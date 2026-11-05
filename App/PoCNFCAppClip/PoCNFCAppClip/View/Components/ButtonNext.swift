//
//  ButtonNext.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 05/11/26.
//

import SwiftUI

struct ButtonNext: View {
    var body: some View {
        Button {
        } label: {
            HStack {
                Text("Escanear livro")
                    .font(.body)
                    .fontWeight(.medium)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                Color("primaryLibrary"),
                in: Capsule()
            )
            .shadow(
                color: .black.opacity(0.20),
                radius: 10,
                x: 0,
                y: 6
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ButtonNext()
}
