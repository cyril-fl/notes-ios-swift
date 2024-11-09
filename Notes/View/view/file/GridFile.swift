import SwiftUI

struct GridFileView: View {
    @EnvironmentObject private var folder : useFolder
    @EnvironmentObject private var file : useFile
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(folder.files, id: \.self) { _file in
                    FileGridCard(_file)
                        .onTapGesture {
                            file.current = _file
                            file.editing.toggle()
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
    
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 300), spacing: 15), count: 2)
    
    private func deleteFile(_ file: File) {
        if let temp = folder.current {
            temp.deleteFileById(fileId: file.id) // Remove from context
        }
    }
}
