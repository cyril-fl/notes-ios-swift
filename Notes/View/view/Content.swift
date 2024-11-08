import SwiftUI
import SwiftData

struct IndexView: View {
    // TODO : Remplacer les state classique par des stateObjet (plus de perf)
    @State private var fo_current = useFolder()
    @State private var fi_current = useFile()
    @State private var alert = useAlert()
    @StateObject private var search = useSearch()

    var body: some View {
        NavigationView {
            VStack {
                if !search.query.isEmpty {
                    SearchView(search.query)
                }
                DetailedFolderView()
            }
            .environmentObject(search)
        }
        .environment(fo_current)
        .environment(fi_current)
        .environment(alert)
        .searchable(text: $search.query, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Recherche"))
        .onChange(of: search.query, {
            print("Search: \(search.query)")
        })
        .alert (alert.title, isPresented: alert.boundState) {
            alert.displayAction()
        } message: {
            alert.display()
        }
    }
}

#Preview {
    IndexView()
        .environment(useFolder())
        .environment(useFile())
        .environment(useAlert())
        .modelContainer(for: Folder.self)
}
