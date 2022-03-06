import SwiftUI

@main
struct AlbumFinderApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SearchView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
