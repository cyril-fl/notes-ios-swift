import SwiftUI

struct FolderListCard: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(useFolder.self) private var currentFolder
    
    @Bindable var folder: Folder
    @State var label: String
    
    init(_ folder: Folder) {
        _folder = .init(folder)
        _label = State(initialValue: folder.name)
    }
    
    var body: some View {
        LabeledContent {
            Text(String(folder.files.count))
                .fontSize(.sm, weight: .semibold)
        } label: {
            Text(label)
                .font(.h3)
            Text("\(folder.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption, color: .primary600)
        }
        .foregroundStyle(.secondary300)
        .onChange(of: currentFolder.editing, initial: false) {
            if !currentFolder.editing {
                label = folder.name
            }
        }
    }
}
