import SwiftUI

struct FileListView: View {
    @Environment(useFolder.self) private var currentFolder
    @Environment(useFile.self) private var currentFile
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                spacing: .sm,
                pinnedViews: [.sectionHeaders]
            ) {
                Section {
                    list
                } header: {
                    HeaderLabel(label: currentFolder.name, font: .h2)
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
            FileCard(file, currentFile)
                .environment(\.defaultFileLayout, currentFile.display)
                .onTapGesture {
                    handleSelection(file)
                }
                .contextMenu{
                    ActionFileView(file: file)
                }
        }
    }
    
    private func handleSelection(_ file: File) {
        currentFile.current = file
        currentFile.editing.toggle()
    }
}
