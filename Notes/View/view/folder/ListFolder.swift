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
                    headerCard
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
                headerCard
            }
        }
    }
    
    private var folderList: some View {
        ForEach(folders, id: \.id) { folder in
            NavigationLink {
                HeaderFileView(currentFile: currentFile)
                    .onAppear {
                        currentFolder.current = folder
                    }
            } label: {
                card(for: folder)
            }
            .contextMenu {
                ActionFolderView(folder)
            }

        }
    }

    private var headerCard: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dossiers")
                    .font(.h1)
                Spacer()
                searchButton
            }
        }
        .background(Color(.systemBackground))
    }

    @ViewBuilder
    private func card(for item: Folder) -> some View {
        switch currentFolder.display {
        case .list:
            FolderListCard(folder: item)
        case .grid:
            FolderGridCard(folder: item)
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
