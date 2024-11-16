import SwiftUI

struct FolderCard: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(\.defaultFileLayout) private var defaultLayout

    var item: Folder
    var currentFolder: useFolder
    
    init(_ item: Folder, _ currentFolder: useFolder) {
        self.item = item
        self.currentFolder = currentFolder
    }
    
    var body: some View {
        Group {
            switch defaultLayout {
            case .list:
                list
            case .grid:
                grid
            }
        }
        .background(Color(.systemBackground))

    }
    
    var list: some View {
        ListCard(item: item)
            .defineAsideContent {
                Text(item.files.count)
                    .lineLimit(1)
            }
            .environment(\.defaultName, defaultName)
            .environment(\.defaultItemKey, currentFolder)
    }
    
    var grid: some View {
        HStack {
            GridCardPreview {
                Image(systemName: "folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .s15, height: .s15)
                    .foregroundStyle(.primary700)
            }
            GridCardLabel(item: item)
                .environment(\.defaultName, defaultName)
                .environment(\.defaultItemKey, currentFolder)
        }
    }
}


struct FileCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(\.defaultFileLayout) private var defaultLayout
    
    var item: File
    var currentFile: useFile
    
    @State var content: String = ""
    
    init(_ item: File, _ currentFile: useFile) {
        self.item = item
        self.currentFile = currentFile
    }
    
    var body: some View {
        Group {
            switch defaultLayout {
            case .list:
                list
            case .grid:
                grid
            }
        }
        .background(Color(.systemBackground))
        .onAppear(perform: handleAppear)
        .onChange(of: currentFile.editing, initial: true, handleUpdate)
    }
    
    var list: some View {
        ListCard(item: item)
            .defineDescriptionContent {
                Text(content)
                    .lineLimit(2)
            }
            .environment(\.defaultName, defaultName)
            .environment(\.defaultItemKey, currentFile)
           
    }

    var grid: some View {
        VStack {
            GridCardPreview(idealH: .s22) {
                Text(content)
            }
            GridCardLabel(item: item)
                .environment(\.defaultName, defaultName)
                .environment(\.defaultItemKey, currentFile)
            Spacer()
        }
    }

    
func handleAppear() {
    content = item.content
}

func handleUpdate() {
    content = item.content
}

}
