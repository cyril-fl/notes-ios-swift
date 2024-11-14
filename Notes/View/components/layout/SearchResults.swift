import SwiftUI
import SwiftData

// TODO : Refactor avec @Bindable si possible
struct SearchResults: View {
    @Environment(useFile.self) private var currentFile
    @Environment(useSearch.self) private var search
    @Environment(useModal.self) private var modal
    
    @State private var results: [File] = []
    private var layout = [GridItem(.flexible())]
    
    var body: some View {
        Group {
            if !search.query.isEmpty {
                VStack {
                    Content
                }
            }
        }
        .frame(maxHeight: 100)
//        .transition(.move(edge: .top))
//        .animation(.easeOut(duration: 0.2), value: results.isEmpty)
        .onChange(of: search.query) {
            DispatchQueue.main.async {
                results = search.query.isEmpty ? [] : search.results.compactMap { $0 as? File }
            }
        }
        .onAppear() {
            modal.current = .SearchModal
        }
        
    }
    var NoResultView: some View {
        UnavailableCard(title: "Notes", message: "Aucune note trouvée", icon: "document")
            .frame(maxHeight: .infinity)
            .opacity(results.isEmpty ? 1 : 0)
    }
    
    var ResultsView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout, spacing: 10) {
                ForEach(results) { _file in
//                    FileGridCard(_file, color: Color(.systemBackground), variant: .search)
//                        .onTapGesture {
//                            currentFile.current = _file
//                            currentFile.editing.toggle()
//                        }
//                        .contextMenu {
//                            ActionFileView(_file)
//                        }
                }
            }
        }
        .padding(.md)
        .background(.secondary100)
        .cornerRadius(.lg)
        .padding(.horizontal, .lg)
        .padding(.bottom, .sm)
        .scrollIndicators(.hidden)
        .frame(maxHeight: results.isEmpty ? 0 : .infinity)
        .opacity(results.isEmpty ? 0 : 1)
    }
    
    var Content: some View {
        Group {
            if results.isEmpty {
                NoResultView
            } else {
                ResultsView
            }
        }
    }
}
