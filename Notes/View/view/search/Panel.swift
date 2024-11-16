import SwiftUI

struct PanelSearchView: View {
    @Bindable var search: useSearch

    var body: some View {
        VStack {
            CSearch<File>(keyPath: \File.content, isPresented: $search.present, reset: true)
            SearchResults()
        }
        .background(.primary600)
        .cornerRadius(.lg)
    }
}
