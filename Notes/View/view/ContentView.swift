import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(useSearch.self) var search
    
    @Bindable var alert: useAlert
    @Bindable var file: useFile
    @Bindable var folder: useFolder
    
    var body: some View {
        NavigationView {
            HeaderFolderView(currentFolder: folder)
        }
        .fullScreenModal(isPresented: $file.editing) {
            FormFileView(file.current!)
        }
        .fullScreenModal(isPresented: $folder.editing, color: .clear, drag: false) {
            FormFolderView(folder.current!, deleteOnCancel: folder.isDeleteOnCancel)
        }
        .alert(alert.title, isPresented: $alert.state) {
            alert.displayAction()
        } message: {
            alert.display()
        }
    }
}


#Preview {
    @Previewable @State var folder = useFolder()
    @Previewable @State var alert = useAlert()
    @Previewable @State var file = useFile()
    @Previewable @State var search = useSearch()
    @Previewable @State var modal = useModal()
    
    ContentView(alert: alert, file: useFile(), folder: folder)
        .environment(folder)
        .environment(file)
        .environment(alert)
        .environment(search)
        .environment(modal)
        .modelContainer(for: Folder.self)
}
