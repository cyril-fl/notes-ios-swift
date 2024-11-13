import SwiftUI


// TODO sync avec ContentFolderView
struct ContentFilesView: View {
//    @Environment(\.presentationMode) var presentationMode
    @Environment(useFolder.self) private var currentFolder

    // Todo try to delete ça
    @Bindable var parent: Folder
    
    // Todo rename current
    @Bindable var currentFile: useFile

    var body: some View {
        Group {
            if currentFolder.files.isEmpty {
                UnavailableCard(title: "Notes", message: "Aucune note trouvé", icon: "document")
            } else {
                FileListView()
            }
        }
        .toolbar {
            //TODO clean toolbar systeme
            HeaderButtonList(display: $currentFile.display, add: addFile)
        }
        .toolbarBackground(Color(.systemBackground), for: .navigationBar)
//        .toolbarBackgroundVisibility(.hidden)
//        .toolbarTitleDisplayMode(.inline)
//        .navigationTitle(currentFolder.name)
        .transition(.move(edge: .trailing).combined(with: .opacity))
        .animation(.easeInOut, value: currentFile.display)
        //TODO : deplacer a un meilleur endroit
        .fullScreenModal(isPresented: $currentFile.editing) {
            FormFileView(currentFile.current)
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
