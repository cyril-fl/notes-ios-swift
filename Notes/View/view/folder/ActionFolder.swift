import SwiftUI

// TODOO Refactor !
struct ActionFolderView: View {
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var currentFolder
    @Environment(useAlert.self) private var alert

    var _f: Folder

    
    init(_ folder: Folder) {
        self._f = folder
    }
    
    var body: some View {
        ForEach(listedAction(_f), id: \.name) { a in
            SwipeButton(label: a.name, icon: a.icon, color: a.color, action: a.action)
        }
    }
    
    private func SwipeButton(label: String, icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label(label, systemImage: icon)
                .foregroundStyle(.secondary200)
        }
        
    }
    
    
    private func listedAction(_ _folder: Folder) -> [SwipeButtonInterface] {
        return [
            SwipeButtonInterface("Delete", icon: "trash", color: .primary600) {
                delete(_folder)
            },
            SwipeButtonInterface("Edit", icon: "pencil", color: .secondary200) {
                currentFolder.isDeleteOnCancel = false
                currentFolder.current = _folder
                currentFolder.editing.toggle()
            }
        ]
    }
    
    private func delete(_ _folder: Folder) {
        withAnimation {
            if _folder.files.count == 0 {
                context.delete(_folder)
                return
            }
            
            alert.title = "Suppression du dossier"
            alert.message = "Votre dossier contient des notes. Le supprimer entraînera la suppression de tout son contenu. Voulez-vous continuer ?"
            alert.state.toggle()
            alert.actions = [
                RoleButtonInterface("Annuler", role: .cancel, action: {}),
                RoleButtonInterface("Supprimer", role: .destructive, action: {
                    context.delete(_folder)
                })
            ]
        }
    }
}
