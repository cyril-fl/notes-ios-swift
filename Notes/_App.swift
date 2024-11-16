import SwiftUI
import SwiftData

// TODO: refactor ce qu'il se trouve ici 
//@main
struct AppDeleteAll: App {
    var body: some Scene {
        WindowGroup {
            DeleteView()
        }
        .modelContainer(for: Folder.self)
        
    }
}

struct DeleteView: View {
    @Environment(\.modelContext) private var context
    
    @Query()
    private var folders: [Folder]
    @Query()
    private var files: [File]
    
    var body: some View {
        VStack {
            Text("List")
                .font(.headline)
                .padding()
            
            List {
                Section(header: Text("Folders")) {
                    ForEach(folders) { folder in
                        Text(folder.name)
                    }
                    Button("Delete All Folders") {
                        deleteFolders()
                    }
                }
                
                Section(header: Text("Files")) {
                    ForEach(files) { file in
                        Text(file.name)
                    }
                    Button("Delete All Files") {
                        deleteFiles()
                    }
                }
            }
        }
        .padding()
    }
    
    // Fonction pour supprimer tous les dossiers
    private func deleteFolders() {
        folders.forEach { folder in
            context.delete(folder)
        }
        saveChanges()
    }
    
    // Fonction pour supprimer tous les fichiers
    private func deleteFiles() {
        files.forEach { file in
            context.delete(file)
        }
        saveChanges()
    }
    
    // Fonction pour sauvegarder les changements dans le contexte
    private func saveChanges() {
        do {
            try context.save()
        } catch {
            print("Error saving changes: \(error.localizedDescription)")
        }
    }
}
