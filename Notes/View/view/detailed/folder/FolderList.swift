import SwiftUI

struct FolderListView: View {
    @Environment(useFolder.self) private var folder
    var folders: [Folder]
    
    var body: some View {
        List(folders, id: \.id) { _folder in
            NavigationLink(destination:
                FilesDetailedView()
                    .onAppear {
                        folder.current = _folder
                }
            ) {
                FolderListCard(_folder)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                FolderAction(_folder)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(Color.clear)
    }
}
