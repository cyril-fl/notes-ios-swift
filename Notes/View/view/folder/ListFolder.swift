import SwiftUI

struct FolderListView: View {
    @Environment(useFolder.self) private var currentFolder
    @Environment(useFile.self) private var currentFile
    @Environment(useSearch.self) private var search
    
    var folders: [Folder]
    
    var body: some View {
        ScrollView {
            searchSection
            
            LazyVGrid (
                columns: columns,
                spacing: 20,
                pinnedViews: [.sectionHeaders]
            ) {
                Section {
                    folderList
                } header: {
                    headerCard(label: "Dossiers")
                }
            }
        }
        .padding(.horizontal, .xl2)
    }
        
    private var columns: [GridItem] {
        let count = currentFolder.display == .grid ? 2 : 1
        return Array(repeating: GridItem(.adaptive(minimum: 300), spacing: 15), count: count)
    }

    @ViewBuilder
    private var searchSection: some View {
        if search.present {
            Section {
                PanelSearchView(search: search)
            } header: {
                headerCard(label: "Recherche")
            }
        }
    }
    
    private var folderList: some View {
        ForEach(folders, id: \.id) { folder in
            NavigationLink {
                MainFileView(currentFile: currentFile)
                    .onAppear {
                        currentFolder.current = folder
                    }
            } label: {
                card(for: $folder)
            }
            .contextMenu {
                ActionFolderView(folder: folder)
            }

        }
    }

    private func headerCard(label: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .Cfont(.h1)
                Spacer()
                searchButton
            }
        }
        .background(Color(.systemBackground))
    }

    @ViewBuilder
    private func card(for item: Binding<Folder>) -> some View {
        switch currentFolder.display {
        case .list:
            Text("List")
//            ListCard(item: item)
//                .defineAsideContent(content: {
//                    Text(String(item.files.count))
//                })
        case .grid:
            GridCardLabel(item: item)
//            FolderGridCard(folder: item)
        }
    }

    @ViewBuilder
    private var searchButton: some View {
        if !search.present {
            CButton("", icon: "magnifyingglass", style: .accent, size: .xs) {
                search.present.toggle()
            }
            .animation(.easeInOut, value: search.present)
        }
    }
}
