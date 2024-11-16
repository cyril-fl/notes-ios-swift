import SwiftUI

struct FormFolderView: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var folder: Folder
    
    @State var name: String = ""
    @State var previous: String = ""
    
    @FocusState var isFocus: Bool
    
    var isDeleteOnCancel: Bool
 
    var body: some View {
        Form {
            formLabel
            formNameInput
            formActions
        }
        .formStyle(.popup)
        .onAppear(perform: handleInit)
        .onChange(of: name, initial: false) { old, new in
            guard !new.isEmpty, new != old, new != folder.name else { return }
            folder.name = new
        }
    }
    
    private var formLabel: some View {
        Text("Renommer le dossier")
            .fontSize(.xl, weight: .semibold)
            .foregroundStyle(.primary950)
            .padding(.bottom, .xs)
    }
    
    private var formNameInput : some View {
        TextField(previous, text: $name)
            .padding(.vertical, .sm)
            .padding(.horizontal, .md)
            .background(.secondary100)
            .foregroundStyle(.secondary600)
            .cornerRadius(.md)
            .focused($isFocus)
            .tint(.primary700)
    }
    
    private var formActions: some View {
        HStack(spacing: .sm) {
            cancelButton
            submitButton
        }
    }
    
    private var submitButton: some View {
        CButton("Enregistrer", style: .primary) {
            if folder.name != previous {
                folder.lastUpdateDate = Date()
            }
            dismiss()
        }
    }
    
    private var cancelButton: some View {
        CButton("Annuler", style: .secondary) {
            withAnimation {
                if isDeleteOnCancel {
                    context.delete(folder)
                }
                folder.name = previous
                dismiss()
            }
        }
    }
    
    private func handleInit() {
        name = folder.name.isEmpty ? defaultName : folder.name
        previous = folder.name.isEmpty ? defaultName : folder.name
        isFocus = true
    }
}

//#Preview {
//    let temp = Folder(name: "Nouveau dossier", path: "")
//    
//
//    ZStack {
//        CModalOverlay()
//            
//        FormFolderView(folder: temp, isDeleteOnCancel: false)
//            .zIndex(40)
//            .environment(\.defaultFolderName, "Nouveau dossier")
//            .environment(useFolder())
//            .environment(useFile())
//            .environment(useAlert())
//            .environment(useSearch())
//            .modelContainer(for: Folder.self)
//    }
//}
