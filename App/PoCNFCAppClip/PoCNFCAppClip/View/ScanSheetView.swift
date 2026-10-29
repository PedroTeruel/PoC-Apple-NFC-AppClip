//
//  ScanSheetView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//
import SwiftUI

struct ScanSheetView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Text("Pronto para escanear")
                .font(.title2.bold())

            Image(systemName: "wave.3.right.circle")
                .font(.system(size: 88, weight: .light))
                .foregroundStyle(.tint)
                .accessibilityHidden(true)

            Text("Aproxime a parte superior do celular da tag NFC do livro.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ScanSheetView()
}
