import SwiftUI

struct FilesDetailedView: View {
    var folder: Folder
    
    @State private var files: [File]
    @State private var selectedFile: File? = nil
    @State private var displayMode: DisplayMode = .list
    
    init(folder: Folder) {
        self.folder = folder
        self._files = State(initialValue: folder.files)
    }
    
    var body: some View {
        ZStack {
            // TODO Refactor
            FilesContentView(folder: folder, files: $files, displayMode: $displayMode, selectedFile: $selectedFile)
        }
        .sheet(item: $selectedFile) { file in
            FileEditSheetView(file: file)
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HeaderButtonList(display: $displayMode, addAction: addFile)
            }
        }
    }
    
    private func addFile() {
        let _new = File(name: "New File", content: "", path: "\(folder.path)\(folder.name)")
        
        withAnimation {
            files.append(_new)
            folder.addFile(newFile: _new)
            selectedFile = _new
        }
    }
}

