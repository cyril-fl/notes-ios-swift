import SwiftUI

struct FolderListView: View {
    var folders: [Folder]
    
    var body: some View {
        List(folders, id: \.id) { _folder in
            NavigationLink(destination: FilesDetailedView(folder: _folder)) {
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
