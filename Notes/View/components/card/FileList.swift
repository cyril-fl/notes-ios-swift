import SwiftUI

// TODO : Refactor comme FolderistCard
struct FileListCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(useFile.self) private var currentFile
    
    @Bindable var file: File
    @State var name: String = "nkjnk"
    @State var content: String = ""
    
    var color: Color = .primary400
    var variant: FileGridCardVariant = .base
        
    var body: some View {
        card
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity)
            .onAppear() {
                handleAppear()
            }
            .onChange(of: currentFile.editing, initial: false) {
                guard !currentFile.editing else { return }
                updateView()
            }
    }
    
    private var card: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                label
                note
                lastUpdate
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    var label: some View {
        Text(name)
            .font(.headline)
            .foregroundStyle(.secondary900)
    }
    
    var note: some View {
        Text(content)
            .font(.subheadline)
            .foregroundStyle(.secondary500)
            .lineLimit(2)
    }
    
    var lastUpdate: some View {
        Text("\(file.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
            .font(.caption)
            .foregroundStyle(.secondary500)
    }
    
    private func handleAppear() {
        name = file.name.isEmpty ? defaultName : file.name
        content = file.content
    }
    
    private func updateView() {
        name = file.name
        content = file.content
    }
}
