import SwiftUI

struct GridFolderView: View {
    @Environment(useFolder.self) private var folder
    var folders: [Folder]
        
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(folders, id: \.id) { _folder in
                    NavigationLink(destination:
                        DetailedFileView()
                            .onAppear {
                                folder.current = _folder
                        }
                    ) {
                        FolderGridCard(_folder)
                    }
                    .contextMenu{
                        ActionFolderView(_folder)
                    }
                } 
            }
        }
        .foregroundStyle(.secondary900)
    }
    
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 300), spacing: 15), count: 2)
}
