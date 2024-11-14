import SwiftUI

struct FileListView: View {
    @Environment(useFolder.self) private var currentFolder
    @Environment(useFile.self) private var currentFile
    @Environment(useModal.self) private var modal
        
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                spacing: 20,

                pinnedViews: [.sectionHeaders]
            ) {
                Section {
                    fileList
                } header: {
                    headerCard
                }
        

            }
            
        }
        .padding(.horizontal, .xl2)
        .onAppear {
            modal.current = .EditModal
        }
    }
    
    private var columns: [GridItem] {
        let count = currentFile.display == .grid ? 2 : 1
        return Array(repeating: GridItem(.adaptive(minimum: 300), spacing: 15), count: count)
    }
    
    private var fileList: some View {
        ForEach(currentFolder.files, id: \.id) { file in
            card(for: file)
                .onTapGesture {
                    selectFile(file)
                }
                .contextMenu{
                    ActionFileView(file)
                }
        }
    }
    
    private var headerCard: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(currentFolder.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.h2)
            }
        }
        .background(Color(.systemBackground))
    }
    
    @ViewBuilder
    private func card(for item: File) -> some View {
        switch currentFolder.display {
        case .list:
            FileListCard(file: item)
        case .grid:
            FileGridCard(file: item)
        }
    }
    
    private func selectFile(_ file: File) {
        currentFile.current = file
        currentFile.editing.toggle()
    }
}


//private func deleteFile(_ file: File) {
//    currentFolder.current?.deleteFileById(fileId: file.id)
//}
