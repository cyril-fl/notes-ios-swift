import SwiftUI

struct DetailedFileView: View {
    @EnvironmentObject private var folder : useFolder
    @EnvironmentObject private var file : useFile
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var modal : useModal
    
    var body: some View {
        ZStack {
            FilesContentView()
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeaderButtonList(display: file.boundDisplay, add: addFile)
            }
        }
        .onAppear {
            modal.current = .EditModal
        }
        .fullScreenModal(isPresented: file.boundEditing) {
            FormFileView()
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

