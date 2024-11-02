import SwiftUI
import SwiftData

struct IndexView: View {
    @State private var fo_current = useFolder()
    @State private var fi_current = useFile()

    var body: some View {
        NavigationView {
            FoldersDetailedView()
                .environment(fo_current)
                .environment(fi_current)

        }
    }
}

#Preview {
    IndexView()
        .environment(useFolder())
        .environment(useFile())
        .modelContainer(for: Folder.self)

}
