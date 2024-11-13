import SwiftUI

// Refactor OK
struct FormFolderView: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var folder: Folder
    
    @State var name: String = ""
    @State var previous: String = ""
    @FocusState var isFocus: Bool
    
    var isDeleteOnCancel: Bool
    
    init(_ folder: Folder, deleteOnCancel: Bool) {
        _folder = .init(folder)
        isDeleteOnCancel = deleteOnCancel
    }
    
    var body: some View {
        Form {
            FormLabel
            
            TextField(previous, text: $name)
                .padding(.vertical, .sm)
                .padding(.horizontal, .md)
                .background(.secondary100)
                .foregroundStyle(.secondary600)
                .cornerRadius(.md)
                .focused($isFocus)
                .tint(.primary700)
                            
            HStack(spacing: .sm) {
                ForEach(actionListItems, id: \.name) { action in
                    CButton(action.name, style: action.style, action: action.action)
                }
            }
        }
        .formStyle(.popup)
        .onAppear() {
            name = folder.name.isEmpty ? defaultName : folder.name
            previous = folder.name.isEmpty ? defaultName : folder.name
            isFocus = true
        }
        .onChange(of: name, initial: false) { old, new in
            if !new.isEmpty && new != old && new != folder.name {
                folder.name = new
            }
        }
    }
    
    private var FormLabel: some View {
        Text("Renommer le dossier")
            .fontSize(.xl, weight: .semibold)
            .foregroundStyle(.primary950)
            .padding(.bottom, .xs)
    }
    
    private var actionListItems: [StyledButtonInterface] {
         [
            StyledButtonInterface("Annuler", style: .secondary, action: handleCancel),
            StyledButtonInterface("Enregistrer", style: .primary,  action: handleSubmit)
         ]
     }
    
    private func handleSubmit() {
        if folder.name != previous {
            folder.lastUpdateDate = Date()
        }
        dismiss()
    }

    private func handleCancel() {
        withAnimation {
            if isDeleteOnCancel {
                context.delete(folder)
            }
            folder.name = previous
            dismiss()
        }
    }
}

#Preview {
    let temp = Folder(name: "Nouveau dossier", path: "")
    

    ZStack {
        CModalOverlay()
            
        FormFolderView(temp, deleteOnCancel: false)
            .zIndex(40)
            .environment(\.defaultFolderName, "Nouveau dossier")
            .environment(useFolder())
            .environment(useFile())
            .environment(useAlert())
            .environment(useSearch())
            .environment(useModal())
            .modelContainer(for: Folder.self)
    }
}
