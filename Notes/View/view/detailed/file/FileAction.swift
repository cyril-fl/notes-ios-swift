import SwiftUI

struct FolderAction: View {
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var folder

    var _f: Folder
    
    init(_ folder: Folder) {
        self._f = folder
    }
    
    var body: some View {
        ForEach(actionList(_f), id: \.label) { a in
            ActionButton(label: a.label, icon: a.icon, color: a.color, action: a.action)
        }
    }
    
    private func ActionButton(label: String, icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label(label, systemImage: icon)
                .foregroundStyle(.secondary50)
        }
        .tint(color)
    }

    private func actionList(_ _folder: Folder) -> [ActionItem] {
        return [
            ActionItem(label: "Delete", icon: "trash", color: .secondary950) {
                deleteFolder(_folder)
            },
            ActionItem(label: "Edit", icon: "square.and.pencil", color: .secondary600) {
                folder.keepOnCancel()
                folder.current = _folder
                folder.editing.toggle()
            }
        ]
    }
    
    private func deleteFolder(_ folder: Folder) {
        withAnimation {
            context.delete(folder)
        }
    }
}
