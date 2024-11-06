import SwiftUI

struct FileEditSheetView: View {
    @Environment(useFolder.self) private var folder
    @Environment(useFile.self) private var file

    @State private var _name: String = "Titre"
    @State private var _content: String = ""
    @FocusState private var isFocus: Bool

    var body: some View {
        Form {
            TextField(file.name, text: $_name)
                .font(.title3)
                .fontWeight(.semibold)
            TextEnhancedEditor(text: $_content)
                .textEditorForegroundColor(.secondary950)
                .focused($isFocus)
        }
        .formStyle(.reset)
        .background(Color(.systemGroupedBackground))
        .onAppear {
            _name = file.name
            _content = file.content
            isFocus = true
        }
        .onDisappear {
            handleSubmit()
        }
    }
    
    private func handleSubmit() {
        let temp_name = _name.trimmingCharacters(in: .whitespacesAndNewlines)
        let temp_content = _content.trimmingCharacters(in: .whitespacesAndNewlines)

        if temp_content.isEmpty,
            let temp_fo = folder.current,
            let temp_fi = file.current {
            temp_fo.deleteFileById(fileId: temp_fi.id)
            return
        }
        
        file.name = temp_name
        file.content = temp_content
    }
}
