import SwiftUI

struct DetailedFileView: View {
    @EnvironmentObject private var folder : useFolder
    @EnvironmentObject private var file : useFile
    
    var body: some View {
        ZStack {
            FilesContentView()
        }
        .fullScreenModal(isPresented: file.boundEditing) {
            FormFileView()
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeaderButtonList(display: file.boundDisplay, add: addFile)
            }
        }
    }
    
    private func addFile() {
        let _new = File(path: "\(folder.path)\(folder.name)")
        
        withAnimation {
            folder.files.append(_new)
            file.current = _new
            file.editing.toggle()
        }
    }
}

