import SwiftUI

struct ListFolderView: View {
    @EnvironmentObject private var folder : useFolder
    var folders: [Folder]
    
    var body: some View {
        List(folders, id: \.id) { _folder in
            NavigationLink(destination:
                DetailedFileView()
                    // TODO La vie apparait avant le current folder soit set et du coup ca pause un probleme a l'engeristrement
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
