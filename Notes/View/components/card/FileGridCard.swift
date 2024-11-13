import SwiftUI

// TODO : Refactor comme FolderistCard
enum FileGridCardVariant {
    case base
    case search
}

struct FileGridCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(useFile.self) private var currentFile
    
    private let key: UUID
    @State private var name: String
    @State private var content: String
    @State private var lastUpdateDate: Date
    private let color: Color
    private let variant: FileGridCardVariant
    
    
    init(_ file: File, color: Color = .secondary50, variant: FileGridCardVariant = .base) {
        self.key = file.id
        self._name = State(initialValue: file.name.isEmpty ? "Nouvelle note" : file.name)
        self._content = State(initialValue: file.content)
        self._lastUpdateDate = State(initialValue: file.lastUpdateDate)
        self.color = color
        self.variant = variant
    }
    
    var body: some View {
        VStack{
            switch variant {
            case .base:
                Group {
                    BaseThumbnail
                    Name
                    UpdateDate
                }
                // TODO : Supprimer  quand j'aurais gerer l'élément de survol.
                .background(Color(.systemBackground))
                
            case .search:
                SearchThumbnail
            }
        }
        .onChange(of: currentFile.current) {
            guard currentFile.id == key else { return }
            name = currentFile.name.isEmpty ? defaultName : currentFile.name
        }
        .onChange(of: currentFile.editing) {
            guard !currentFile.editing else { return }
            updateView()
        }
    }
    
    private func updateView() {
        guard currentFile.id == key else { return }
        name = currentFile.name
        content = currentFile.content
        lastUpdateDate = currentFile.lastUpdateDate
    }
    
    var BaseThumbnail: some View {
        HStack(alignment: .top) {
            VStack {
                Text(content)
                    .font(.caption)
                Spacer()
            }
            Spacer()
        }
        .frame(minHeight: 80)
        .frame(width: 110)
        .frame(maxHeight: 80)
        .padding(10)
        .background(color)
        .cornerRadius(10)
    }
    
    var SearchThumbnail: some View {
        HStack(alignment: .top) {
            VStack {
                Text(content)
                    .font(.caption)
                Spacer()
            }
            Spacer()
        }
        .frame(minHeight: 30)
        .frame(width: 110)
        .padding(10)
        .background(color)
        .cornerRadius(10)
    }
    
    var Name: Text {
        Text(name)
            .font(.headline)
    }
    
    var UpdateDate: Text {
        Text("\(lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
            .font(.footnote)
            .foregroundStyle(.secondary500)
    }
}
