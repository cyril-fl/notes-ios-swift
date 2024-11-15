import SwiftUI


struct FolderListCard: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(useFolder.self) private var currentFolder
    
    @Bindable var folder: Folder
    @State var name: String = ""
    
    var body: some View {
        LabeledContent {
            Text(String(folder.files.count))
                .fontSize(.sm, weight: .semibold)
        } label: {
            Text(name)
                .Cfont(.h3)
            Text("\(folder.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                .Cfont(.h6, color: .primary600)
        }
        .foregroundStyle(.secondary300)
        .onAppear {
            name = folder.name.isEmpty ? defaultName : folder.name
           }
        .onChange(of: currentFolder.editing, initial: false) {
            if !currentFolder.editing {
                name = folder.name
            }
        }
    }
}


struct FileListCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(useFile.self) private var currentFile

    @Bindable var file: File
    @State var name: String = ""
    @State var content: String = ""

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
