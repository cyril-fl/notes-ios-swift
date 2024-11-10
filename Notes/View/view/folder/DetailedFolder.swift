import SwiftUI

struct DetailedFolderView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var folder : useFolder
    
    
    var body: some View {
        ZStack {
            FoldersContentView()
        }
        .navigationTitle("Fichiers")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeaderButtonList(display: folder.boundDisplay ,add: addFolder)
            }
        }
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
