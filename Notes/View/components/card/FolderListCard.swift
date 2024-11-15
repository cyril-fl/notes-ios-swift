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
                .font(.h3)
            Text("\(folder.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption, color: .primary600)
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
