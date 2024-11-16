import SwiftUI

// Refactor OK
struct _FolderGridCard: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(useFolder.self) private var currentFolder
    
    @Bindable var folder: Folder
    @State var name: String = ""
    var color: Color = .secondary50
    
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // TODO: Supprimer  quand j'aurais gerer l'élément de survol.
        .background(Color(.systemBackground))
        .onAppear {
            name = name.isEmpty ? defaultName : name
        }
        .onChange(of: currentFolder.editing, initial: true) {
            if !currentFolder.editing {
                name = folder.name
            }
        }
    }
    
    @ViewBuilder
    private var content : some View {
        Image(systemName: "folder")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .foregroundStyle(.secondary800)
        Text(name)
            .font(.headline)
        
        Group {
            Text("\(currentFolder.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                .font(.footnote)
        }
        .foregroundStyle(.secondary500)
    }
}
