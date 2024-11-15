import SwiftUI
import SwiftData

struct ActionFileView: View {
    @Query() private var folders : [Folder]
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var currentFolder
    @Environment(useFile.self) private var currentFile

    let file: File
        
    var body: some View {
        VStack {
            deleteButton
        }
    }
    
    private var deleteButton: some View {
        Button {
            withAnimation {
                folders.forEach { folder in
                    folder.files.removeAll { $0.id == file.id }
                    context.delete(file)
                }
            }
        } label: {
            Label("Supprimer", systemImage: "trash")
                .foregroundStyle(.secondary200)
        }
    }
}
