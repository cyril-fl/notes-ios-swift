import SwiftUI


struct ListFileView: View {
    @EnvironmentObject private var folder : useFolder
    @EnvironmentObject private var file : useFile
    
    var body: some View {
        List(folder.files, id: \.self) { _file in
            FileListCard(_file)
                .onTapGesture {
                    file.current = _file
                    file.editing.toggle()
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    ActionFileView(_file)
                }
        }
        .listStyle(.plain)
        .background(Color.clear)
    }
}

