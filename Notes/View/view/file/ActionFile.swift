import SwiftUI
import SwiftData


// TODO Refatcor
struct ActionFileView: View {
    @Query() private var folders : [Folder]
    @Environment(\.modelContext) private var context
    @Environment(useFolder.self) private var currentFolder
    @Environment(useFile.self) private var currentFile

    var _f: File
    
    init(_ file: File) {
        self._f = file
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
            switch currentFile.display {
            case .list:
                Image(systemName: icon)
            case .grid:
                Label(label, systemImage: icon)
            }
        }
    }
    
    private func listedAction(_ _file: File) -> [SwipeButtonInterface] {
        return [
            SwipeButtonInterface("Delete", icon: "trash", color: .destructive) {
                deleteFile(_file)
            }
        ]
    }
    
    private func deleteFile(_ file: File) {
        withAnimation {
            folders.forEach { folder in
                folder.files.removeAll { $0.id == file.id }
                context.delete(file)
            }
        }
    }
}
