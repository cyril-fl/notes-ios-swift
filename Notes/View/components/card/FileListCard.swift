import SwiftUI

struct FileListCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @EnvironmentObject private var file : useFile

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
        .onChange(of: file.current) {
            guard file.current !== nil else { return }
            guard !isLoaded else { return }
            name = file.name.isEmpty ? defaultName : file.name
            isLoaded = true
        }
        .onChange(of: file.editing, initial: false) {
            if !file.editing {
                updateView()
            }
        }
    }
    
    private func updateView() {
        guard file.id == key else { return }
            name = file.name
            content = file.content
            lastUpdateDate = file.lastModified
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
