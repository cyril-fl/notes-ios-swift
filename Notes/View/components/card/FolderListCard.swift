import SwiftUI

struct FolderListCard: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(useFolder.self) private var folder
    // TODO remplacer     @Environment(useFolder.self) private var folder par ce qui est prescrit dans la doc ave @bindable
    
    
    private let key: UUID
    @State private var name: String
    private var count: Int
    
    init(_ folder: Folder) {
        self.key = folder.id
        self._name = State(initialValue: folder.name)
        self.count = folder.files.count
    }
    
    var body: some View {
        LabeledContent {
            Text(String(count))
                .fontSize(.sm, weight: .semibold)
        } label: {
            Text(name)
                .font(.h3)
            Text("\(folder.lastModified.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption, color: .primary600)
        }
        .foregroundStyle(.secondary300)
        .onAppear {
            name = name.isEmpty ? defaultName : name
        }
        .onChange(of: folder.editing, initial: false) {
            if !folder.editing {
                updateView()
            }
        }
    
    }
    
    private func updateView() {
        guard folder.id == key else { return }
        name = folder.name
    }
}
