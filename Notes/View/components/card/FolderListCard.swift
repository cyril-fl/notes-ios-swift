import SwiftUI

struct FolderListCard: View {
    var _f: Folder
    
    init(_ _f: Folder) {
        self._f = _f
    }
    
    var body: some View {
        LabeledContent {
            Text(String(_f.files.count))
                .font(.footnote)
        } label: {
            Text(_f.name)
                .foregroundStyle(.secondary900)
                .font(.headline)
            Text("\(_f.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
        }
        .foregroundStyle(.secondary500)
    }
}
