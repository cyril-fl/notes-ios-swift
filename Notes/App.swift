import SwiftUI
import SwiftData

@main
struct NotesApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                IndexView()
                    .border(.accent)
                    .modelContainer(for: Folder.self)
                
                WindowBis {
                    VStack {
                        Text("Hello from WindowBis")
                            .font(.title)
                        Button("Close") {
                            // Action de fermeture ou autre logique ici
                        }
                    }
                }
            }
            
        }
        
        
    }
}
