import SwiftUI

struct FormFolderView: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Environment(useFolder.self) private var folder

    @State private var _name: String = ""
    @State private var _previous: String = ""
    @FocusState private var isFocus: Bool
    
    var body: some View {
        Form {
            FormLabel
            
            TextField(_previous, text: $_name)
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
            _name = folder.name.isEmpty ? defaultName : folder.name
            _previous = folder.name.isEmpty ? defaultName : folder.name
            isFocus = true
        }
        .onChange(of: _name, initial: false) { old, new in
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
        if folder.name != _previous {
            folder.lastModified = Date()
        }
        dismiss()
    }

    private func handleCancel() {
        withAnimation {
            if folder.delete, let folder = folder.current {
                context.delete(folder)
            }
            folder.name = _previous
            dismiss()
        }
    }
}

#Preview {
    ZStack {
        CModalOverlay()
            
        FormFolderView()
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
