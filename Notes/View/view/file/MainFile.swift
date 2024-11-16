import SwiftUI

struct MainFileView: View {
    @Environment(useFolder.self) private var currentFolder
    
    @Bindable var currentFile: useFile
    
    var body: some View {
        content
            .toolbar {
                addButton
                displayButton
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
    
    private var displayButton: some ToolbarContent {
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




#Preview {
    @Previewable @State var folder = useFolder()
    @Previewable @State var alert = useAlert()
    @Previewable @State var file = useFile()
    @Previewable @State var search = useSearch()
    
    MainFileView(currentFile: file)
        .onAppear() {
            folder.current = Folder(name: "Main file", path: "/")
            for i in 0..<10 {
                folder.current?.newFile(
                    name: "Folder \(i)",
                    content: "String")
            }
            
        }
        .environment(folder)
        .environment(file)
        .environment(alert)
        .environment(search)
        .modelContainer(for: Folder.self)
}
