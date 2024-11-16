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
                    list
                } header: {
                    HeaderLabel(label: "Dossiers", font: .h1) {
                        searchButton
                    }
                }
            }
        }
        .padding(.horizontal, .xl2)
    }
    
    private var columns: [GridItem] {
        let count = currentFolder.display == .grid ? 2 : 1
        return Array(repeating: GridItem(.adaptive(minimum: 300), spacing: 15), count: count)
    }
        
    private var list: some View {
        ForEach(folders, id: \.id) { folder in
            NavigationLink {
                MainFileView(currentFile: currentFile)
                    .onAppear {
                        currentFolder.current = folder
                    }
            } label: {
                FolderCard(folder, currentFolder)
                    .environment(\.defaultFileLayout, currentFolder.display)
            }
            .contextMenu {
                ActionFolderView(folder: folder)
            }
            
        }
    }
    
    @ViewBuilder
    private var searchSection: some View {
        if search.present {
            Section {
                PanelSearchView(search: search)
            } header: {
                HeaderLabel(label: "Recherche")
            }
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
