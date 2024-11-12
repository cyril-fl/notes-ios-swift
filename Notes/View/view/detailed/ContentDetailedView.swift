import SwiftUI
import SwiftData

struct FoldersContentView: View {
    @Environment(useFolder.self) private var folder

    @Query(sort: \Folder.lastUpdateDate, order: .reverse, animation: .easeIn)
    private var folders: [Folder]

    var body: some View {
        if folders.isEmpty {
            UnavailableCard(title: "Fichiers", message: "Aucune fichier trouvé", icon: "folder")
        } else {
            Group {
                switch folder.display {
                case .list:
                    ListFolderView(folders: folders)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                case .grid:
                    GridFolderView(folders: folders)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: folder.display)
        }
    }
}

struct FilesContentView: View {
    @Environment(useFolder.self) private var folder
    @Environment(useFile.self) private var file

    var body: some View {
        if folder.files.isEmpty {
            UnavailableCard(title: "Notes", message: "Aucune note trouvé", icon: "document")
        } else {
            Group {
                switch file.display {
                case .list:
                    ListFileView()
                        .transition(.move(edge: .leading).combined(with: .opacity))
                case .grid:
                    GridFileView()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: file.display)
        }
    }
}
