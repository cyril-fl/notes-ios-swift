import SwiftUI

struct FormFileView: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var currentFolder
    
    @Bindable private var file: File

    @State private var name: String = ""
    @State private var content: String = ""
    @State private var previous: String = ""
    
    @FocusState private var isNameFocused: Bool
    @FocusState private var isContentFocused: Bool
    
    init(_ file: File) {
        _file = .init( file)
    }
    
    var body: some View {
        Form {
            TextField(previous, text: $name)
                .font(.title3)
                .fontWeight(.semibold)
                .focused($isNameFocused)
                .tint(.primary600)
                .onSubmit {
                    isContentFocused = true
                }
            TextEnhancedEditor(text: $content)
                .textEditorForegroundColor(.secondary950)
                .focused($isContentFocused)
                .tint(.primary600)
        }
        .formStyle(.reset)
        .onAppear {
            name = file.name.isEmpty ? defaultName : file.name
            previous = file.name.isEmpty ? defaultName : file.name
            content = file.content
            handleFocus()
        }
        .onChange(of: name, initial: false) { old, new in
            file.name = new
        }
        .onChange(of: content, initial: false) { old, new in
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
        guard content.isEmpty,
              let _file = currentFolder.files.first(where: { $0.id == file.id })
        else {
            print("ICI")
            currentFolder.lastUpdateDate = Date()
            return
        }

        withAnimation {
            currentFolder.current?.deleteFileById(fileId: file.id)
            context.delete(_file)
        }
    }
}
