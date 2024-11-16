import SwiftUI
import SwiftData

@main
struct NotesApp: App {
    @State private var alert = useAlert()
    @State private var file = useFile()
    @State private var folder = useFolder()
    @State private var search = useSearch()

    init() {
        initNavigationBarStyle()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(alert: alert, file: file, folder: folder)
        }
        .modelContainer(for: Folder.self)
        .environment(alert)
        .environment(file)
        .environment(folder)
        .environment(search)
    }
    
    private func initNavigationBarStyle() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .systemBackground
        navBarAppearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}
