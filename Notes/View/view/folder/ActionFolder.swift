import SwiftUI

struct ActionFolderView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var folder : useFolder    
    @EnvironmentObject private var alert : useAlert

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
            ButtonLabel(label, icon)
                .foregroundStyle(.secondary50)
        }
        .tint(color)
    }
    
    private func ButtonLabel(_ label: String, _ icon: String) -> some View {
        Group {
            switch folder.display {
            case .list:
                Image(systemName: icon)
            case .grid:
                Label(label, systemImage: icon)
            }
        }
    }
    
    private func listedAction(_ _folder: Folder) -> [SwipeButtonInterface] {
        return [
            SwipeButtonInterface("Delete", icon: "trash", color: .destructive) {
                delete(_folder)
            },
            SwipeButtonInterface("Edit", icon: "pencil", color: .primary300) {
                folder.keepOnCancel()
                folder.current = _folder
                folder.editing.toggle()
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
            alert.isPresented.toggle()
            alert.actions = [
                RoleButtonInterface("Annuler", role: .cancel, action: {}),
                RoleButtonInterface("Supprimer", role: .destructive, action: {
                    context.delete(_folder)
                })
            ]
        }
    }
}
