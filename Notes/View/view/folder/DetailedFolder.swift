import SwiftUI

struct DetailedFolderView: View {
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var folder

    var body: some View {
        ZStack {
            
            FoldersContentView()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HeaderButtonList(display: folder.boundDisplay ,add: addFolder)
            }
        }
        .toolbarBackground(Color(.systemBackground), for: .navigationBar)
//        .toolbarBackgroundVisibility(.hidden)

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
