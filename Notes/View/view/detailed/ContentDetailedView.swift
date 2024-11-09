import SwiftUI
import SwiftData

struct FoldersContentView: View {
    @EnvironmentObject private var folder : useFolder
    @EnvironmentObject private var display : useDisplay
    

    @Query(sort: \Folder.lastUpdateDate, order: .reverse, animation: .easeIn)
    private var folders: [Folder]

    var body: some View {
        if folders.isEmpty {
            UnavailableCard(title: "Fichiers", message: "Aucune fichier trouvé", icon: "folder")
        } else {
            Group {
                switch display.mode {
                case .list:
                    ListFolderView(folders: folders)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                case .grid:
                    GridFolderView(folders: folders)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: display.mode)
        }
    }
}

struct FilesContentView: View {
    @Environment(useFolder.self) private var folder
    @Environment(useFile.self) private var file
    @EnvironmentObject private var display : useDisplay

    
    var body: some View {
        if folder.files.isEmpty {
            UnavailableCard(title: "Notes", message: "Aucune note trouvé", icon: "document")
        } else {
            Group {
                switch display.mode {
                case .list:
                    ListFileView()
                        .transition(.move(edge: .leading).combined(with: .opacity))
                case .grid:
                    GridFileView()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: display.mode)
        }
    }
}
