import SwiftUI

struct FolderEditSheetView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Environment(useFolder.self) private var folder

    @State private var _name: String = ""
    @FocusState private var isFocus: Bool
    
    var body: some View {
        Form {
            FormLabel
            
            TextField(placeholder, text: $_name)
                .padding(.vertical, 4)
                .padding(.horizontal, 7)
                .background(.secondary100)
                .foregroundStyle(.secondary600)
                .cornerRadius(10)
                .focused($isFocus)
                            
            HStack {
                ForEach(actionListItems, id: \.name) { action in
                    CButton(action.name, style: action.style, action: action.action)
                    .padding(.top, 10)
                }
            }
            
        }
        .formStyle(.popup)
        .onAppear() {
            _name = folder.name.isEmpty ? "Nouveau dossier" : folder.name
            isFocus = true
        }
    }
    
    private var FormLabel: some View {
        Text("Renommer le dossier")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.secondary900)
    }
    
    private var actionListItems: [StyledButtonInterface] {
         [
            StyledButtonInterface("Annuler", style: .secondary, action: handleCancel),
            StyledButtonInterface("Enregistrer", style: .primary,  action: handleSubmit)
         ]
     }
    
    private var placeholder: String {
        return folder.name.isEmpty ? "Nouveau dossier" : folder.name
    }
    
    private func handleSubmit() {
        folder.name = _name.isEmpty ? "Nouveau dossier" : _name
        dismiss()
    }

    private func handleCancel() {
        withAnimation {
            if folder.delete, let folder = folder.current {
                context.delete(folder)
            }
            dismiss()
        }
    }
}
