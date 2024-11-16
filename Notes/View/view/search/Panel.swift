import SwiftUI

struct PanelSearchView: View {
    @Bindable var search: useSearch

    var body: some View {
//        DisclosureGroup {
//            
//        }
        
        VStack {
            CSearch<File>(keyPath: \File.content, isPresented: $search.present, reset: true)
            SearchResults()
        }
//        .sheet(item: Binding<Identifiable?>) {
//            Text("e")
//                .det
//        }
        
        .background(.primary600)
        .cornerRadius(.lg)
    }
}
