import SwiftUI


struct FileListView: View {
//    @Environment(\.modelContext) private var context
//    @Environment(useFile.self) private var file

    
    
    var folder: Folder
    @Binding var files: [File]
    @Binding var selectedFile: File?
    
    var body: some View {
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
                    .foregroundStyle(.secondary50)
                    .tint(.secondary950)
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

