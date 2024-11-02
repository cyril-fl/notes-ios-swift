import SwiftUI

struct FileGridView: View {
    @Environment(\.modelContext) private var context
    var folder: Folder
    @Binding var files: [File]
    @Binding var selectedFile: File?

    // Définir les colonnes de la grille
    private let columns: [GridItem] = [
        GridItem(.flexible()), // Colonne flexible
        GridItem(.flexible()), // Colonne flexible
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(folder.files, id: \.self) { file in
                    FileGridCard(file: file)
                        .onTapGesture {
                            selectedFile = file
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                deleteFile(file)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }

            }
            .padding()
            .background(Color.clear)
        }
    }
    
    
    
    var bodyOG: some View {
        List(folder.files, id: \.self) { file in
            FileListCard(file: file)
                .onTapGesture {
                    selectedFile = file
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        deleteFile(file)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
        }
        .listStyle(.plain)
        .background(Color.clear)
        
    }
    
    private func deleteFile(_ file: File) {
        guard let index = files.firstIndex(where: { $0.id == file.id }) else {
            return
        }
        files.remove(at: index) // Remove from view
        folder.deleteFileById(fileId: file.id) // Remove from context
    }
}
