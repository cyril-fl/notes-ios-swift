import SwiftUI

struct ActionFolderView: View {
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var currentFolder
    @Environment(useAlert.self) private var alert
    
    let folder: Folder
    
    var body: some View {
        VStack {
            deleteButton
            editButton
        }
    }
    
    private var deleteButton: some View {
        Button {
            withAnimation {
                guard folder.files.isEmpty else {
                    showAlert()
                    return
                }
                context.delete(folder)
            }
        } label: {
            Label("Supprimer", systemImage: "trash")
                .foregroundStyle(.secondary200)
        }
    }
    
    private var editButton: some View {
        Button {
            startEditing()
        } label: {
            Label("Edit", systemImage: "pencil")
                .foregroundStyle(.secondary200)
        }
    }
    
    private func showAlert() {
        alert.title = "Suppression du dossier"
        alert.message = "Votre dossier contient des notes. Le supprimer entraînera la suppression de tout son contenu. Voulez-vous continuer ?"
        alert.actions = [
            RoleButtonInterface("Annuler", role: .cancel, action: {}),
            RoleButtonInterface("Supprimer", role: .destructive, action: {
                context.delete(folder)
            })
        ]
        alert.state.toggle()
    }
    
    private func startEditing() {
        currentFolder.isDeleteOnCancel = false
        currentFolder.current = folder
        currentFolder.editing.toggle()
    }
}
