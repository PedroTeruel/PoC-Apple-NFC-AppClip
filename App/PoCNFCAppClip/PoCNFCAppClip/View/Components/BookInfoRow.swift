//
//  BookInfoRow.swift
//  PoCNFCAppClip
//
//  Created by Mariana Fracaroli Lopes on 04/11/26.
//

import SwiftUI

struct BookInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.gray)

            Spacer()

            Text(value)
                .foregroundStyle(.black)
                .multilineTextAlignment(.trailing)
        }
        .font(.system(size: 16))
    }
}
