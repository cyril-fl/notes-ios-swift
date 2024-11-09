import SwiftUI

struct FormFolderView: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var folder : useFolder
    
    @State private var _name: String = ""
    @State private var _placeholder: String = ""
    @FocusState private var isFocus: Bool
    
    var body: some View {
        Form {
            FormLabel
            
            TextField(_placeholder, text: $_name)
                .padding(.vertical, 4)
                .padding(.horizontal, 7)
                .background(.secondary100)
                .foregroundStyle(.secondary600)
                .cornerRadius(10)
                .focused($isFocus)
                .tint(.primary500)
                            
            HStack {
                ForEach(actionListItems, id: \.name) { action in
                    CButton(action.name, style: action.style, action: action.action)
                    .padding(.top, 10)
                }
            }
        }
        .formStyle(.popup)
        .onAppear() {
            _name = folder.name.isEmpty ? defaultName : folder.name
            _placeholder = folder.name.isEmpty ? defaultName : folder.name
            isFocus = true
        }
        .onChange(of: _name) { old, new in
            folder.name = new
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
    
    
    private func handleSubmit() {
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
