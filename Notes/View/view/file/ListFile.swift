import SwiftUI


struct ListFileView: View {
    @Environment(useFolder.self) private var folder
    @Environment(useFile.self) private var file

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

