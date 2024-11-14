import SwiftUI

struct HeaderFileView: View {
    @Environment(useFolder.self) private var currentFolder
    
    @Bindable var currentFile: useFile
    
    var body: some View {
        content
            .fullScreenModal(isPresented: $currentFile.editing) {
                FormFileView(currentFile.current!)
            }
            .toolbar {
                addButton
                toogleDisplayMode
            }
    }
    
    @ViewBuilder
    var content : some View {
        if currentFolder.files.isEmpty {
            UnavailableCard(title: "Notes", message: "Aucune note trouvé", icon: "document")
        } else {
            FileListView()
        }
    }
    
    private var addButton : some ToolbarContent {
        ToolbarItem {
            CButton("plus", icon: "plus", style: .accent, size: .xs) {
                withAnimation {
                    let _new = File(path: "\(currentFolder.path)\(currentFolder.name)")
                    currentFolder.files.append(_new)
                    currentFile.current = _new
                    currentFile.editing.toggle()
                }
            }
        }
    }
    
    private var toogleDisplayMode: some ToolbarContent {
        ToolbarItem {
            let icon = currentFile.display == .list ? "square.grid.2x2" : "list.bullet"
            
            CButton(icon, icon: icon, style: .accent, size: .xs) {
                withAnimation {
                    currentFile.display.toggle()
                }
            }
        }
    }
}



