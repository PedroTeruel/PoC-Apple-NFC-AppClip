//
//  DefaultClipApp.swift
//  DefaultClip
//
//  Created by Pedro Henrique Hossaka Teruel on 28/10/26.
//

//import SwiftUI
//
//@main
//struct DefaultClipApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
import SwiftUI

@main
struct DefaultClipApp: App {
    @State private var library = Library()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BooksView()
            }
            .environment(library)
        }
    }
}
