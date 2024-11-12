import SwiftUI

struct FolderGridCard: View {
    @Environment(\.defaultFolderName) private var defaultName
    @Environment(useFolder.self) private var folder
        
    private let key: UUID
    @State private var name: String
    @State private var lastUpdateDate: Date
    private let color: Color
    
    init(_ folder: Folder, color: Color = .secondary50) {
        self.key = folder.id
        self._name = State(initialValue: folder.name)
        self._lastUpdateDate = State(initialValue: folder.lastUpdateDate)
        self.color = color
    }
    
    var body: some View {
        HStack{
            VStack {
                Image(systemName: "folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.secondary800)
                Text(name)
                    .font(.headline)
                
                Group {
                    Text("\(lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                }
                .foregroundStyle(.secondary500)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground)) // TODO : Supprimer  quand j'aurais gerer l'élément de survol.
        .onAppear {
            name = name.isEmpty ? defaultName : name
           }
        .onChange(of: folder.editing, initial: false) {
            if !folder.editing {
                updateView()
            }
        }
    }
    
    private func updateView() {
        guard folder.id == key else { return }
        name = folder.name
        lastUpdateDate = folder.lastModified
    }
}
