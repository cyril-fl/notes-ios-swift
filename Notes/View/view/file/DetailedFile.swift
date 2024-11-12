import SwiftUI

struct DetailedFileView: View {
    @Environment(useFolder.self) private var folder
    @Environment(useFile.self) private var file
    @Environment(\.presentationMode) var presentationMode
    @Environment(useModal.self) private var modal

    var body: some View {
        ZStack {
            FilesContentView()
        }
        .navigationTitle(folder.name)
        
        //TODO clean toolbar systeme
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeaderButtonList(display: file.boundDisplay, add: addFile)
            }
        }
        .toolbarTitleDisplayMode(.inline)
        
        .toolbarBackground(Color(.systemBackground), for: .navigationBar)
//        .toolbarBackgroundVisibility(.hidden)

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

