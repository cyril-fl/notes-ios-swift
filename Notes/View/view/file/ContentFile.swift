import SwiftUI

struct ContentFilesView: View {
    @Environment(useFolder.self) private var currentFolder
    
    @Bindable var currentFile: useFile
    
    var body: some View {
        content
            .toolbar {
                ToolbarItem {
                    CButton("plus", icon: "plus", style: .accent, size: .xs, action: addFile)
                }
                ToolbarItem {
                    CButton(toggledIcon, icon: toggledIcon, style: .accent, size: .xs, action: toggleViewMode)
                }
            }
    }
    
    private var toggledIcon: String {
        currentFile.display == .list ? "square.grid.2x2" : "list.bullet"
    }
    
    private func toggleViewMode() {
        withAnimation {
            currentFile.display.toggle()
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
    
    private func addFile() {
        withAnimation {
            let _new = File(path: "\(currentFolder.path)\(currentFolder.name)")
            currentFolder.files.append(_new)
            currentFile.current = _new
            currentFile.editing.toggle()
        }
    }
}

//TODO : deplacer a un meilleur endroit
//    .fullScreenModal(isPresented: $currentFile.editing) {
//        FormFileView(currentFile.current!)
//    }


// .toolbarBackgroundVisibility(.hidden)
// .toolbarTitleDisplayMode(.inline)
// .navigationTitle(currentFolder.name)
// .toolbarBackground(Color(.systemBackground), for: .navigationBar)



