import SwiftUI

struct FolderEditSheetView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Environment(useFolder.self) private var folder

    @State private var _name: String = ""
        
    var body: some View {
        Form {
            FormLabel
            
            TextField(folder.name, text: $_name)
            
            Spacer()
            
            HStack {
                ForEach(actionListItems, id: \.label) { action in
                    Button(action: action.action) {
                        Text(action.label)
                    }
                    .buttonStyle(action.style)
                }
            }
        }
        .frame(maxWidth: 300, maxHeight: 150)
        .padding(15)
        .formStyle(.columns)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(10)
        .onAppear() {
            _name = folder.name
        }
    }
    
    private var FormLabel: some View {
        Text("Renommer le dossier")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.secondary50)
            .padding(.bottom, 10)
    }
    
    private var actionListItems: [LabelAction] {
         [
            (label: "Annuler", action: handleCancel, style: .secondary),
            (label: "Enregistrer", action: handleSubmit, style: .primary)
         ]
     }
    
    private func handleSubmit() {
        folder.name = _name
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
