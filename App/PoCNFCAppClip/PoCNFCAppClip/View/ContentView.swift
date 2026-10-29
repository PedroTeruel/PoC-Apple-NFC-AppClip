import SwiftUI

struct ContentView: View {
    @State private var library = Library()
    @State private var selectedTab: LibraryTab = .books

    var body: some View {
        TabView(selection: $selectedTab) {
            Color.clear
                .tabItem {
                    Label("Locações", systemImage: "books.vertical")
                }
                .tag(LibraryTab.loans)

            NavigationStack {
                BooksView()
            }
            .tabItem {
                Label("Livros", systemImage: "book.closed")
            }
            .tag(LibraryTab.books)

            Color.clear
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
                .tag(LibraryTab.profile)
        }
        .environment(library)
    }
}

private enum LibraryTab: Hashable {
    case loans
    case books
    case profile
}

#Preview {
    ContentView()
}
