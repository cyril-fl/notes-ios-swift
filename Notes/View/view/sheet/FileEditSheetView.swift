import SwiftUI

struct FileEditSheetView: View {
    var file: File

    var body: some View {
        Text(file.name)
            .foregroundStyle(.secondary50)
    }
}
