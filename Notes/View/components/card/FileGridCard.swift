import SwiftUI

struct FileGridCard: View {
    var file: File
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(file.name)
                .font(.headline)
            Text("Path: \(file.path)")
                .font(.subheadline)
                .foregroundStyle(.secondary50)
            Text("Last updated: \(file.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                .font(.footnote)
                .foregroundStyle(.secondary50)
        }
    }
}
