import SwiftUI
import SwiftData

struct FoldersContentView: View {
    @Environment(useFolder.self) private var folder
    
    @Query(sort: \Folder.lastUpdateDate, order: .reverse, animation: .easeIn)
    private var folders: [Folder]

    var body: some View {
        if folders.isEmpty {
            UnavailableCard(label: "folder", icon: "folder")
        } else {
            Group {
                switch folder.display {
                case .list:
                    FolderListView(folders: folders)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                case .grid:
                    FolderGridView(folders: folders)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: folder.display)
        }
    }
}

//struct FilesContentView: View {
//    @Environment(useFile.self) private var file
//
//    var folder: Folder
//    @Binding var files: [File]
//    @Binding var selectedFile: File?
//    
//    var body: some View {
//        
//        if files.isEmpty {
//            UnavailableCard(label: "file", icon: "document")
//        } else {
//            Group {
//                switch file.display {
//                case .list:
//                    FileListView(folder: folder, files: $files, selectedFile: $selectedFile)
//                        .transition(.move(edge: .leading).combined(with: .opacity))
//                case .grid:
//                    FileGridView(folder: folder, files: $files, selectedFile: $selectedFile)
//                        .transition(.move(edge: .trailing).combined(with: .opacity))
//                }
//            }
//            .animation(.easeInOut, value: file.display)
//        }
//    }
//}


struct FilesContentView: View {
    var folder: Folder
    @Binding var files: [File]
    @Binding var displayMode: DisplayMode
    @Binding var selectedFile: File?
    //    @Binding var isPrevent: Bool
    var body: some View {
        
        if files.isEmpty {
            UnavailableCard(label: "file", icon: "document")
        } else {
            Group {
                switch displayMode {
                case .list:
                    FileListView(folder: folder, files: $files, selectedFile: $selectedFile)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                case .grid:
                    FileGridView(folder: folder, files: $files, selectedFile: $selectedFile)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: displayMode)
        }
    }
}
