import SwiftUI

struct ListFolderView: View {
    @Environment(useFolder.self) private var folder
    var folders: [Folder]
    
    var body: some View {
        List(folders, id: \.id) { _folder in
            NavigationLink(destination:
                DetailedFileView()
                    .onAppear {
                        folder.current = _folder
                }
            ) {
                FolderListCard(_folder)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                ActionFolderView(_folder)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(Color.clear)
    }
}
