//
//  ContentView.swift
//  PoCNFCAppClip
//
//  Created by Pedro Henrique Hossaka Teruel on 27/10/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var library = Library()

    @StateObject private var nfcManager = NFCManager()

    var body: some View {
        NavigationStack {
            BooksView()
        }
        .environment(library)
    }
}

#Preview {
    ContentView()
}
