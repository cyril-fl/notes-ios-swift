import SwiftUI
import SwiftData

struct ContentFoldersView: View {
    @Query(sort: \Folder.lastUpdateDate, order: .reverse, animation: .easeIn)
     var folders: [Folder]

    @Environment(\.modelContext) private var context
    
    @Bindable var currentFolder: useFolder
    
    var body: some View {
        content
            .toolbar {
                //TODO: clean toolbar systeme
                ToolbarItem {
                    CButton("plus", icon: "plus", style: .accent, size: .xs, action: addFolder)
                }
                ToolbarItem {
                    CButton(toggledIcon, icon: toggledIcon, style: .accent, size: .xs, action: toggleViewMode)
                }
            }
    }
    
    private var toggledIcon: String {
        currentFolder.display == .list ? "square.grid.2x2" : "list.bullet"
    }
    
    private func toggleViewMode() {
        withAnimation {
            currentFolder.display.toggle()
        }
    }
    
    @ViewBuilder
    var content : some View {
        if folders.isEmpty {
            UnavailableCard(title: "Fichiers", message: "Aucune fichier trouvé", icon: "folder")
        } else {
            FolderListView(folders: folders)
        }
    }
    
    private func addFolder() {
        withAnimation {
            let _new = Folder(name: "", path: "/")
            context.insert(_new)
            currentFolder.isDeleteOnCancel = true
            currentFolder.current = _new
            currentFolder.editing.toggle()
        }
    }
}
