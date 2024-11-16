import SwiftUI
import SwiftData

struct CSearch<T: PersistentModel & Identifiable>: View {
    @Environment(useFile.self) private var currentFile
    @Environment(useSearch.self) private var search
    
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
                SearchBar
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeInOut, value: isPresented)
        .onDisappear() {
            search.query = ""
            isPresented = false
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
        .Cfont(.h4, color: .primary50)
    }
    
    var SearchBar: some View {
        Form {
            TextField(prompt, text: search.boundQuery)
                .inputStyle(.search, reset: isResetable, search.boundQuery)
            
            if !isAlwaysPresented {
                CancelButton
            }
        }
        .formStyle(.search)
        .onChange(of: search.query) {
            search.filterResults(from: items, usingKey: keyPath)
        }
       
    }
}
