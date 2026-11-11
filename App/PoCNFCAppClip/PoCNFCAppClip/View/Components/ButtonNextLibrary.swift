//
//  ButtonNextLibrary.swift
//  PoCNFCAppClip
//
//  Created by Vinicius de Brito on 06/11/26.
//

import SwiftUI

struct ButtonNextLibrary: View {
    
    let onScan: () -> Void
    
    var body: some View {
        Button(action: onScan) {
            HStack {
                Image(systemName: "wave.3.right")
                    .font(.system(size: 18, weight: .medium))

                Text("Escanear livro")
                    .font(.system(size: 16, weight: .bold))

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .medium))
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
    ButtonNextLibrary(onScan: {})
}
