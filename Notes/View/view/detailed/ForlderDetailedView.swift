import SwiftUI

struct FoldersDetailedView: View {
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var folder

    var body: some View {
        ZStack {
            FoldersContentView()
            screenColorOverlay()
        }
        .fullScreenCover(item: folder.boundSelected) { folder in
            FolderEditSheetView()
                .presentationBackground(Color.clear)
        }
        .navigationTitle("Folders")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeaderButtonList(display: folder.boundDisplay, addAction: addFolder)
            }
        }
    }
    
    private func addFolder() {
        withAnimation {
            let _new = Folder(name: "New Folder", path: "/")
            context.insert(_new)
            folder.deleteOnCancel()
            folder.current = _new
        }
    }
    
    private func screenColorOverlay() -> some View {
        folder.current != nil
        ? ScreenColorOverlay()
        : nil;
    }
}
