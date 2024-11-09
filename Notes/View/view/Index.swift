import SwiftUI
import SwiftData

struct Index: View {
    @StateObject private var fo_current = useFolder()
    @StateObject private var fi_current = useFile()
    @StateObject private var alert = useAlert()
    @StateObject private var search = useSearch()
    @StateObject private var display = useDisplayV2()



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
        .environmentObject(fo_current)
        .environmentObject(fi_current)
        .environmentObject(alert)
        .environmentObject(display)
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
    Index()
        .environmentObject(useFolder())
        .environmentObject(useFile())
        .environmentObject(useAlert())
        .modelContainer(for: Folder.self)
}
