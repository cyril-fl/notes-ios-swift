import SwiftUI

struct DetailedFolderView: View {
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var folder

    var body: some View {
        ZStack {
            FoldersContentView()
            screenColorOverlay()
        }
        .fullScreenCover(isPresented: folder.boundEditing, content: {
            FormFolderView()
                .presentationBackground(Color.clear)
        })
        .navigationTitle("Fichiers")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeaderButtonList(display: folder.boundDisplay, add: addFolder)
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
    
    private func screenColorOverlay() -> some View {
        folder.editing
        ? ScreenColorOverlay()
        : nil;
    }
}
