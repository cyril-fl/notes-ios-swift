import SwiftUI
import SwiftData

// TODOO sync avec contentFileView
struct ContentFoldersView: View {
    @Query(sort: \Folder.lastUpdateDate, order: .reverse, animation: .easeIn)
    private var folders: [Folder]
    
    @Environment(\.modelContext) private var context
    
    @Bindable var current: useFolder
    
    var body: some View {
        Group {
            if folders.isEmpty {
                UnavailableCard(title: "Fichiers", message: "Aucune fichier trouvé", icon: "folder")
            } else {
                FolderListView(folders: folders)
            }
        }
        .toolbar {
            //TODO clean toolbar systeme
            HeaderButtonList(display: $current.display, add: addFolder)
        }
        .toolbarBackground(Color.white, for: .navigationBar)
//        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        .transition(.move(edge: .leading).combined(with: .opacity))
        .animation(.easeInOut, value: current.display)
        
    }
    
    private func addFolder() {
        withAnimation {
            let _new = Folder(name: "", path: "/")
            context.insert(_new)
            current.isDeleteOnCancel = true
            current.current = _new
            current.editing.toggle()
        }
    }
}
