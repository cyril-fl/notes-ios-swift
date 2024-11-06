import SwiftUI

struct FileListCard: View {
    var _f: File
    
    init(_ file: File) {
        self._f = file
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Name
               
                Text(_f.content)
                    .font(.subheadline)
                    .foregroundStyle(.secondary500)
                    .lineLimit(2)
                Text("\(_f.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption)
                    .foregroundStyle(.secondary500)
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
    }
    
    var Name: some View {
        Group {
            if !_f.name.isEmpty {
                Text(_f.name)
                    .font(.headline)
                    .foregroundStyle(.secondary900)
            }
        }
    }
}
