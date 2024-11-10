import SwiftUI
import SwiftData

struct Index: View {
    @StateObject private var fo_current = useFolder()
    @StateObject private var fi_current = useFile()
    @StateObject private var alert = useAlert()
    @StateObject private var search = useSearch()

    var body: some View {
        NavigationView {
            VStack {
                if !search.query.isEmpty {
                    SearchView(search.query)
                }
                DetailedFolderView()
            }
            .fullScreenModal(isPresented: fi_current.boundEditing) {
                FormFileView()
            }
            .environmentObject(search)
        }
        .environmentObject(fo_current)
        .environmentObject(fi_current)
        .environmentObject(alert)
        .searchable(text: $search.query, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Recherche"))
        .alert (alert.title, isPresented: alert.boundState) {
            alert.displayAction()
        } message: {
            alert.display()
        }
    }
}

#Preview {
    Index()
        .environmentObject(useFolder())
        .environmentObject(useFile())
        .environmentObject(useAlert())
        .modelContainer(for: Folder.self)
}
