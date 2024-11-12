import SwiftUI
import SwiftData

struct ContentFoldersView: View {
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var folder

    @Query(sort: \Folder.lastUpdateDate, order: .reverse, animation: .easeIn)
    private var folders: [Folder]

    
    var body: some View {
        Group {
            if folders.isEmpty {
                UnavailableCard(title: "Fichiers", message: "Aucune fichier trouvé", icon: "folder")
            } else {
                Group {
                    // TODOO : ⚠️ Refactor
                    switch folder.display {
                    case .list:
                        ListFolderView(folders: folders)
                            .transition(.move(edge: .leading).combined(with: .opacity))
                    case .grid:
                        GridFolderView(folders: folders)
                            .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                    // ---
                }
                .animation(.easeInOut, value: folder.display)
            }
        }

        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HeaderButtonList(display: folder.boundDisplay ,add: addFolder)
            }
        }
        .toolbarBackground(Color(.systemBackground), for: .navigationBar)
        .toolbarBackgroundVisibility(.hidden)
    }
    
        private func addFolder() {
            withAnimation {
                let _new = Folder(name: "", path: "/")
                context.insert(_new)
                folder.deleteOnCancel()
                folder.current = _new
                folder.editing.toggle()
            }
        }
}
