import SwiftUI

struct FolderListCard: View {
    @Environment(\.defaultFolderName) private var defaultName
    @EnvironmentObject private var folder: useFolder
    
    private let key: UUID
    @State private var name: String
    private var count: Int
    @State private var lastUpdateDate: Date
    
    init(_ folder: Folder) {
        self.key = folder.id
        self._name = State(initialValue: folder.name)
        self.count = folder.files.count
        self._lastUpdateDate = State(initialValue: folder.lastUpdateDate)
    }
    
    var body: some View {
        LabeledContent {
            Text(String(count))
                .font(.footnote)
        } label: {
            Text(name)
                .foregroundStyle(.secondary900)
                .font(.headline)
            Text("\(lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
        }
        .foregroundStyle(.secondary500)
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
        lastUpdateDate = folder.lastModified
    }
}
