//
//  BackButton.swift
//  PoCNFCAppClip
//
//  Created by Mariana Fracaroli Lopes on 04/11/26.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
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

    }
    
}
