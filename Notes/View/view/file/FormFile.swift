import SwiftUI

struct FormFileView: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var currentFolder
    
    @Bindable var file: File
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var previousT: String = ""
    @State private var previousD: String = ""

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
        .onChange(of: title, initial: false) { old, new in
            guard !new.isEmpty, new != old, new != file.name else { return }
            file.name = new
        }
        .onChange(of: description, initial: false) { old, new in
            guard !new.isEmpty, new != old, new != file.content else { return }
            file.content = new
        }
        .onDisappear {
            handleAutoDelete()
        }
    }
    
    private var formNameInput: some View {
        TextField(previousT, text: $title)
            .font(.title3)
            .fontWeight(.semibold)
            .focused($isNameFocused)
            .tint(.primary600)
            .onSubmit {
                isContentFocused = true
            }
    }
    
    private var formContentInput: some View {
        TextEnhancedEditor(text: $description)
            .textEditorForegroundColor(.secondary950)
            .focused($isContentFocused)
            .tint(.primary600)
    }
    
    private func handleInit() {
        title = file.name.isEmpty ? defaultName : file.name
        previousT = title
        description = file.content
        previousD = description
    }
    
    private func handleFocus() {
        isNameFocused = file.name.isEmpty ? true : false
        isContentFocused = file.name.isEmpty ? false : true
    }
    
    private func handleAutoDelete() {
        withAnimation {
            guard description.isEmpty else {
                handleUpdate()
                return
            }
            currentFolder.current?.deleteFileById(fileId: file.id)
            context.delete(file)
        }
    }
    
    private func handleUpdate() {
        guard (description != previousD || title != previousT) else { return }
        currentFolder.lastUpdateDate = Date()
        file.lastUpdateDate = Date()
    }
}
