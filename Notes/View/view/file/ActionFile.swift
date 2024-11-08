import SwiftUI

struct ActionFileView: View {
    @Environment(useFolder.self) private var folder
    @Environment(useFile.self) private var file

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
            switch file.display {
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
            if let temp = folder.current {
                temp.deleteFileById(fileId: file.id) // Remove from context
            }
        }
    }
}
