import SwiftUI


// TODOO Refactor
struct FileListView: View {
    @Environment(useFolder.self) private var currentFolder
    @Environment(useFile.self) private var currentFile
    @Environment(useModal.self) private var modal

    var body: some View {
        Group {
            switch currentFile.display {
            case .list:
                ListFileView()
                    .transition(.move(edge: .leading).combined(with: .opacity))
            case .grid:
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(currentFolder.files, id: \.self) { _file in
                            FileGridCard(_file)
                                .onTapGesture {
                                    currentFile.current = _file
                                    currentFile.editing.toggle()
                                }
                                .contextMenu{
                                    ActionFileView(_file)
                                }
                        }
                    }
                    .padding()
                    .background(Color.clear)
                }
            }
        }
        .onAppear {
            modal.current = .EditModal
        }
    }
    
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 300), spacing: 15), count: 2)
    
    private func deleteFile(_ file: File) {
        currentFolder.current.deleteFileById(fileId: file.id) // Remove from context
    }
}

struct ListFileView: View {
    @Environment(useFolder.self) private var currentFolder
    @Environment(useFile.self) private var currentFile
    
    var body: some View {
        List(currentFolder.files, id: \.self) { _file in
            
            FileListCard(_file)
                .onTapGesture {
                    currentFile.current = _file
                    currentFile.editing.toggle()
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    ActionFileView(_file)
                }
        }
        .listStyle(.plain)
        .background(Color.clear)
    }
}
