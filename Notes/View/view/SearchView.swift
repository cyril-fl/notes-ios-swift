import SwiftUI
import SwiftData

struct SearchView: View {
    @EnvironmentObject private var file: useFile
    @Query var files: [File]
    
    private var layout = [GridItem(.flexible())]
    
    init(_ query: String) {
        _files = Query(filter: #Predicate<File> { file in
            file.content.contains(query)
        }, sort: \.content, animation: .linear)
    }
    
    var body: some View {
        VStack {
            if files.isEmpty {
                UnavailableCard(title: "Notes", message: "Aucune note trouvée", icon: "document")
                    .frame(maxHeight: files.isEmpty ? .infinity : 0)
                    .opacity(files.isEmpty ? 1 : 0)
                    
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: layout, spacing: 10) {
                        ForEach(files) { _file in
                            FileGridCard(_file, color: Color(.systemBackground))
                                .onTapGesture {
                                    file.current = _file
                                    file.editing.toggle()
                                }
                                .contextMenu {
                                    ActionFileView(_file)
                                }
                        }
                    }
                }
                .padding(10)
                .background(.secondary100)
                .cornerRadius(10)
                .padding(.horizontal, 15)
                .scrollIndicators(.hidden)
                .frame(maxHeight: files.isEmpty ? 0 : .infinity)
                .opacity(files.isEmpty ? 0 : 1)
                
            }
        }
        .frame(maxHeight: 100)
        .transition(.move(edge: .top))
        .animation(.easeOut(duration: 0.2), value: files.isEmpty)
    }
}
