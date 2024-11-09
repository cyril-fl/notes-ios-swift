import SwiftUI

struct DetailedFolderView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var folder : useFolder
    @StateObject private var display = useDisplay(preset: .list)
    
    
    var body: some View {
        ZStack {
            FoldersContentView()
        }
        .fullScreenModal(isPresented: folder.boundEditing, color: .clear, drag: false) {
            FormFolderView()
        }
        .navigationTitle("Fichiers")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeaderButtonList(add: addFolder)
            }
        }
        .environmentObject(display)
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
