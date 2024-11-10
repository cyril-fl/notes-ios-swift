import SwiftUI
import SwiftData

// Origial
//        .searchable(text: $search.query, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Recherche"))

// Ajouter un display mode 

struct CSearch<T: PersistentModel & Identifiable & Searchable>: View {
    @EnvironmentObject private var file: useFile
    @EnvironmentObject private var search : useSearch
    var prompt: String = "Recherche"
    var keyPath: KeyPath<T, String>
        
    @Query private var items: [T]
    
    var body: some View {
        VStack {
            Form {
                TextField(prompt, text: search.boundQuery)
                    .inputStyle(.search, reset: true, search.boundQuery)
            }
            .formStyle(.search)
        }
        .onChange(of: search.query) {
            search.filterResults(from: items, usingKey: keyPath)
        }
    }
}
