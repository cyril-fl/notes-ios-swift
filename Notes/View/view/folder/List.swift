import SwiftUI

// TODO ameliorer la toolbard

struct FolderListView: View {
    @Environment(useFolder.self) private var currentFolder
    @Environment(useFile.self) private var currentFile
    @Environment(useSearch.self) private var search
    
    var folders: [Folder]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, pinnedViews: [.sectionHeaders]) {
                Section(header: Header) {
                    ForEach(folders, id: \.id) { _folder in
                        
                        NavigationLink {
                            ContentFilesView(parent: _folder, currentFile: currentFile)
                                .onAppear {
                                    currentFolder.current = _folder
                                }
                        } label: {
                            Content(_folder)
                            
                        }
                        .contextMenu{
                            ActionFolderView(_folder)
                        }
                    }
                }
            }
        }
        
//        .toolbarBackground(Color(.systemBackground), for: .navigationBar)
//        .toolbarBackgroundVisibility(.visible)
//        
        .padding(.horizontal, .lg)
        .background(Color(.systemBackground))

    
//        .foregroundStyle(.secondary900)
    }
    
    private var columns: [GridItem] {
        let count = currentFolder.display == .grid ? 2 : 1
        return Array(repeating: GridItem(.adaptive(minimum: 300), spacing: 15), count: count)
    }
    
    private func Content(_ _folder: Folder) -> some View {
        Group {
            switch currentFolder.display {
            case .list:
                FolderListCard(folder: _folder)
            case .grid:
                FolderGridCard(folder: _folder)
                
            }
        }
    }
    
    private var Header: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dossiers")
                    .font(.h1)
                Spacer()
                toggleSearchButton
            }
        }
        
        
        //        .padding(.horizontal)
        .background(Color(.systemBackground))
                
        
        //        .listRowInsets(EdgeInsets())
    }
    
    var toggleSearchButton: some View {
        Group {
            if !search.present {
                CButton("", icon: "magnifyingglass", style: .accent, size: .xs) {
                    search.present.toggle()
                }
                .animation(.easeInOut, value: search.present)
            }
        }
    }
    
    
}

