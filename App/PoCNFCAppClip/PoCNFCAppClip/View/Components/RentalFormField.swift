//
//  RentalFormField.swift
//  PoCNFCAppClip
//
//  Created by Mariana Fracaroli Lopes on 05/11/26.
//

import SwiftUI

struct RentalFormField: View {

    let title: String
    let placeholder: String

    @Binding var text: String

    var keyboard: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack(spacing: 3) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.primary)

                Text("*")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.red)
            }

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .foregroundStyle(Color.gray.opacity(0.45))
            )
            .font(.system(size: 17))
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
