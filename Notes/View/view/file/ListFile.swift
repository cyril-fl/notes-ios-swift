import SwiftUI

struct FileListView: View {
    @Environment(useFolder.self) private var currentFolder
    @Environment(useFile.self) private var currentFile
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                spacing: .xl5,
                pinnedViews: [.sectionHeaders]
            ) {
                Section {
                    list
                } header: {
                    headerCard
                }
            }
        }
        .padding(.horizontal, .xl2)
    }
    
    private var columns: [GridItem] {
        let count = currentFile.display == .grid ? 3 : 1
        return Array(repeating: GridItem(.adaptive(minimum: 300), spacing: 15), count: count)
    }
    
    private var list: some View {
        ForEach(currentFolder.files, id: \.id) { file in
            card(for: file)
                .onTapGesture {
                    handleSelection(file)
                }
                .contextMenu{
                    ActionFileView(file: file)
                }
        }
    }
        
    private var headerCard: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(currentFolder.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .Cfont(.h2)
            }
        }
        .background(Color(.systemBackground))
    }
    
    @ViewBuilder
    private func card(for item: File) -> some View {
        switch currentFile.display {
        case .list:
            ListCard(item: item)
                .defineDescriptionContent(content: {
                    Text(item.content)
                })
        case .grid:
            VStack {
//                GridCardPreview(content: Text(item.content))
//                GridCardLabel<File>(Item: item)
            }
        }
    }
    
    private func handleSelection(_ file: File) {
        currentFile.current = file
        currentFile.editing.toggle()
    }
}
