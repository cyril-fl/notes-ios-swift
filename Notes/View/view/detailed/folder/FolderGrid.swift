import SwiftUI

struct FolderGridView: View {
    var folders: [Folder]
        
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(folders, id: \.id) { folder in
                    NavigationLink(destination: FilesDetailedView(folder: folder)) {
                        FolderGridCard(_f: folder)
                            .background(Color.white) // Couleur de fond blanche pour l'exemple
                    }
                    .contextMenu{
                        FolderAction(folder)
                    }
                }
                
            }
        }
        .foregroundStyle(.secondary900)
    }
    
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 300), spacing: 15), count: 2)
}
