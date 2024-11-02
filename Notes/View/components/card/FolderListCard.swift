import SwiftUI

struct FolderListCard: View {
    var folder: Folder
    
    init(_ folder: Folder) {
        self.folder = folder
    }
    
    var body: some View {
        LabeledContent {
            Text(String(folder.files.count))
                .font(.footnote)
        } label: {
            Text(folder.name)
                .foregroundStyle(.secondary900)
                .font(.headline)
            Text("\(folder.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
        }
        .foregroundStyle(.secondary500)
    }
}
