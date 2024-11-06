import SwiftUI

struct FilesDetailedView: View {
    @Environment(useFolder.self) private var folder
    @Environment(useFile.self) private var file
    
    var body: some View {
        ZStack {
            FilesContentView()
        }
        .customFullScreenCover(isPresented: file.boundEditing) {
            FileEditSheetView()
                .presentationCornerRadius(25)
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeaderButtonList(display: file.boundDisplay, add: addFile)
            }
        }
    }
    
    private func addFile() {
        let _new = File(name: "Nouvelle note", content: "", path: "\(folder.path)\(folder.name)")
        
        withAnimation {
            folder.files.append(_new)
            file.current = _new
            file.editing.toggle()
        }
    }
}

