import SwiftUI
import SwiftData

struct MainFolderView: View {
    @Query(sort: \Folder.lastUpdateDate, order: .reverse, animation: .easeIn)
     var folders: [Folder]

    @Environment(\.modelContext) private var context
    
    @Bindable var currentFolder: useFolder
        
    var body: some View {
        content
            .toolbar {
                addButton
                displayButton
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
        
    private var addButton : some ToolbarContent {
        ToolbarItem {
            CButton("plus", icon: "plus", style: .accent, size: .xs) {
                withAnimation {
                    let _new = Folder(name: "", path: "/")
                    context.insert(_new)
                    currentFolder.isDeleteOnCancel = true
                    currentFolder.current = _new
                    currentFolder.editing.toggle()
                }
            }
        }
    }

    private var displayButton: some ToolbarContent {
        ToolbarItem {
            let icon = currentFolder.display == .list ? "square.grid.2x2" : "list.bullet"
            
            CButton(icon, icon: icon, style: .accent, size: .xs) {
                withAnimation {
                    currentFolder.display.toggle()
                }
            }
        }
    }
}

//// TODO ameliorer la toolbard
////    .toolbar {
////        // TODO: clean toolbar systeme
////        HeaderButtonList(display: $current.display, add: addFolder)
////    }
////    .toolbarBackground(Color(.systemBackground), for: .navigationBar)
////    .toolbarBackgroundVisibility(.visible)
////    .padding(.horizontal, .lg)
////    .background(Color(.systemBackground))
////    .foregroundStyle(.secondary900)
