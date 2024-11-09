import SwiftUI

struct FormFileView: View {
    @Environment(\.defaultFileName) private var defaultName
    @EnvironmentObject private var folder : useFolder
    @EnvironmentObject private var file : useFile

    @State private var _name: String = ""
    @State private var _content: String = ""
    @State private var _placeholder: String = ""
    @FocusState private var isNameFocused: Bool
    @FocusState private var isContentFocused: Bool

    var body: some View {
        Form {
            TextField(_placeholder, text: $_name)
                .font(.title3)
                .fontWeight(.semibold)
                .focused($isNameFocused)
                .tint(.primary600)
            TextEnhancedEditor(text: $_content)
                .textEditorForegroundColor(.secondary950)
                .focused($isContentFocused)
                .tint(.primary600)
        }
        .formStyle(.reset)
        .onAppear {
            _name = file.name.isEmpty ? defaultName : file.name
            _placeholder = file.name.isEmpty ? defaultName : file.name
            _content = file.content
            handleFocus()
        }
        .onChange(of: _name, initial: false) { old, new in
            file.name = new
        }
        .onChange(of: _content, initial: false) { old, new in
            file.content = new
        }
        .onDisappear {
            handleAutoDelete()
        }
    }
    
    private func handleFocus() {
        if file.name.isEmpty {
            isNameFocused = true
            isContentFocused = false
        } else {
            isNameFocused = false
            isContentFocused = true
        }
    }
    
    private func handleAutoDelete() {
        guard _content.isEmpty else { return }
        guard let idToDelete = file.current?.id else { return }
        guard let folderToUpdate = folder.current else { return }
        
        withAnimation {
            folderToUpdate.deleteFileById(fileId: idToDelete)
        }
    }
}
