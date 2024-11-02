import SwiftUI
import SwiftData

@main
struct NotesApp: App {
    var body: some Scene {
        WindowGroup {
            IndexView()
                .modelContainer(for: Folder.self)
        }
    }
}
