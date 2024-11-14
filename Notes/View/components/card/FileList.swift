import SwiftUI

// TODO : Refactor comme FolderistCard
struct FileListCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(useFile.self) private var currentFile
    
    @Bindable var file: File
    @State var name: String = ""
    @State var content: String = ""
    
    var color: Color = .primary400
    var variant: FileGridCardVariant = .base
        
    var body: some View {
        HStack(alignment: .top) {
            contentView
            Spacer()
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
        .onChange(of: currentFile.current) {
            name = currentFile.name.isEmpty ? defaultName : currentFile.name
        }
        .onChange(of: currentFile.editing, initial: false) {
            if !currentFile.editing {
                updateView()
            }
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading) {
            Name
            Text(content)
                .font(.subheadline)
                .foregroundStyle(.secondary500)
                .lineLimit(2)
            Text("\(file.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption)
                .foregroundStyle(.secondary500)
        }
    }
    
    private func updateView() {
        name = currentFile.name
        content = currentFile.content
    }
    
    @ViewBuilder
    var Name: some View {
        if !name.isEmpty {
            Text(name)
                .font(.headline)
                .foregroundStyle(.secondary900)
        }
    }
}
