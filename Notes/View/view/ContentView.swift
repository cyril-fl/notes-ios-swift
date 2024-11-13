import SwiftUI
import SwiftData
// Refactor - OK
struct ContentView: View {
    @Environment(useSearch.self) var search
    
    @Bindable var alert: useAlert
    @Bindable var file: useFile
    @Bindable var folder: useFolder
    
    var body: some View {
        NavigationView {
            VStack {
                PanelSearchView(search: search)
                ContentFoldersView(current: folder)
            }
        }
        .fullScreenModal(isPresented: $file.editing) {
            FormFileView(file.current)
        }
        .fullScreenModal(isPresented: $folder.editing, color: .clear, drag: false) {
            FormFolderView(folder.current, deleteOnCancel: folder.isDeleteOnCancel)
        }
        .alert(alert.title, isPresented: $alert.state) {
            alert.displayAction()
        } message: {
            alert.display()
        }
    }
}


    #Preview {
        ContentView(alert: useAlert(), file: useFile(), folder: useFolder())
            .environment(useFolder())
            .environment(useFile())
            .environment(useAlert())
            .environment(useSearch())
            .environment(useModal())
            .modelContainer(for: Folder.self)
    }
