import SwiftUI

// TODO : Refactor comme FolderistCard
struct FileListCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(useFile.self) private var currentFile

    private let key: UUID
    @State private var name: String
    @State private var content: String
    @State private var lastUpdateDate: Date
    @State private var isLoaded: Bool = false
    
    init(_ file: File) {
        self.key = file.id
        self._name = State(initialValue: file.name)
        self._content = State(initialValue: file.content)
        self._lastUpdateDate = State(initialValue: file.lastUpdateDate)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Name
               
                Text(content)
                    .font(.subheadline)
                    .foregroundStyle(.secondary500)
                    .lineLimit(2)
                Text("\(lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption)
                    .foregroundStyle(.secondary500)
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
        .onChange(of: currentFile.current) {
            
            guard !isLoaded else { return }
            name = currentFile.name.isEmpty ? defaultName : currentFile.name
            isLoaded = true
        }
        .onChange(of: currentFile.editing, initial: false) {
            if !currentFile.editing {
                updateView()
            }
        }
    }
    
    private func updateView() {
        guard currentFile.id == key else { return }
            name = currentFile.name
            content = currentFile.content
            lastUpdateDate = currentFile.lastUpdateDate
    }
    
    var Name: some View {
        Group {
            if !name.isEmpty {
                Text(name)
                    .font(.headline)
                    .foregroundStyle(.secondary900)
            }
        }
    }
}
