import SwiftUI

struct FormFileView: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var currentFolder
    
    @Bindable var file: File
    
    @State private var name: String = ""
    @State private var content: String = ""
    @State private var previous: String = ""
    
    @FocusState private var isNameFocused: Bool
    @FocusState private var isContentFocused: Bool
    
    var body: some View {
        Form {
            formNameInput
            formContentInput
        }
        .formStyle(.reset)
        .onAppear {
            handleInit()
            handleFocus()
        }
        .onChange(of: name, initial: false) { old, new in
            guard !new.isEmpty, new != old, new != file.name else { return }
            file.name = new
        }
        .onChange(of: content, initial: false) { old, new in
            guard !new.isEmpty, new != old, new != file.content else { return }
            file.content = new
        }
        .onDisappear {
            handleAutoDelete()
        }
    }
    
    
    private var formNameInput: some View {
        TextField(previous, text: $name)
            .font(.title3)
            .fontWeight(.semibold)
            .focused($isNameFocused)
            .tint(.primary600)
            .onSubmit {
                isContentFocused = true
            }
    }
    
    private var formContentInput: some View {
        TextEnhancedEditor(text: $content)
            .textEditorForegroundColor(.secondary950)
            .focused($isContentFocused)
            .tint(.primary600)
    }
    
    

    private func handleInit() {
        name = file.name.isEmpty ? defaultName : file.name
        previous = file.name.isEmpty ? defaultName : file.name
        content = file.content
    }
    
    private func handleFocus() {
        isNameFocused = file.name.isEmpty ? true : false
        isContentFocused = file.name.isEmpty ? false : true
    }
    
    
    private func handleAutoDelete() {
        withAnimation {
            if !content.isEmpty {
                currentFolder.lastUpdateDate = Date()
                file.lastUpdateDate = Date()
                return
            }
            currentFolder.current?.deleteFileById(fileId: file.id)
            context.delete(file)
        }
    }
}
