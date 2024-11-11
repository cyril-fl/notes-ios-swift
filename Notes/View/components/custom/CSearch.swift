import SwiftUI
import SwiftData

struct CSearch<T: PersistentModel & Identifiable & Searchable>: View {
    @EnvironmentObject private var file: useFile
    @EnvironmentObject private var search: useSearch
    
    var prompt: String
    var keyPath: KeyPath<T, String>
    var isAlwaysPresented: Bool
    @Binding var isPresented: Bool
    var isResetable: Bool

    @Query private var items: [T]

    init(_ prompt: String = "Recherche",
         keyPath: KeyPath<T, String>,
         isAlwaysPresented: Bool = false,
         isPresented: Binding<Bool> = .constant(true),
         reset: Bool = false
    ) {
        self.prompt = prompt
        self.keyPath = keyPath
        self.isAlwaysPresented = isAlwaysPresented
        self._isPresented = isPresented
        self.isResetable = reset
    }
    
    var body: some View {
        Group {
            if isAlwaysPresented || isPresented {
                HStack(alignment: .center, spacing: 10) {
                    SearchBar
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeInOut, value: isPresented)
        .onDisappear() {
            search.query = ""
        }
        .onChange(of: isPresented) { old, new in
            if !new {
                search.query = ""
            }
        }

    }
    
    var CancelButton: some View {
        Button("Annuler") {
            withAnimation {
                isPresented.toggle()
            }
        }
    }
    
    var SearchBar: some View {
        VStack {
            Form {
                TextField(prompt, text: search.boundQuery)
                    .inputStyle(.search, reset: isResetable, search.boundQuery)
                
                if !isAlwaysPresented {
                    CancelButton
                }
            }
            .formStyle(.search)
        }
        .onChange(of: search.query) {
            search.filterResults(from: items, usingKey: keyPath)
        }
       
    }
}
