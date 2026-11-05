//
//  ContentView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 27/10/26.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var nfcManager = NFCManager()

    var body: some View {
        NavigationStack {
            BooksView()
        }
    }
}

#Preview {
    ContentView()
}
