import SwiftUI

struct FileGridCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @EnvironmentObject private var file : useFile

    private let key: UUID
    @State private var name: String
    @State private var content: String
    @State private var lastUpdateDate: Date
    @State private var isLoaded: Bool = false
    private let color: Color

    
    init(_ file: File, color: Color = .secondary50) {
        self.key = file.id
        self._name = State(initialValue: file.name.isEmpty ? "Nouvelle note" : file.name)
        self._content = State(initialValue: file.content)
        self._lastUpdateDate = State(initialValue: file.lastUpdateDate)
        self.color = color
    }
    
    var body: some View {
        HStack{
            ViewThatFits {
                VStack {
                    Thumbnail
                    Name
                    UpdateDate
                }
                VStack {
                    Thumbnail
                    Name
                }
                VStack {
                    Thumbnail
                }
                
            }

        }
//        .background(Color(.systemBackground)) // TODO : Supprimer  quand j'aurais gerer l'élément de survol.
        .onChange(of: file.current) {
            guard file.current !== nil else { return }
            guard !isLoaded else { return }
            name = file.name.isEmpty ? defaultName : file.name
            isLoaded = true
        }
        .onChange(of: file.editing) {
            if !file.editing {
                updateView()
            }
        }
    }
    
    private func updateView() {
        guard file.id == key else { return }
        name = file.name
        content = file.content
        lastUpdateDate = file.lastModified
    }
    
    var Thumbnail: some View {
        ViewThatFits {
            HStack(alignment: .top) {
                VStack {
                    Text(content)
                        .font(.caption)
                    Spacer()
                }
                Spacer()
            }
            .frame(minHeight: 80)
        
            
            HStack(alignment: .top) {
                VStack {
                    Text(content)
                        .font(.caption)
                    Spacer()
                }
                Spacer()
            }
            .aspectRatio(16.0 / 9, contentMode: .fit) // Force un ratio 1:1, mode fit pour s'adapter
        }
        .frame(width: 110)
        .frame(maxHeight: 80)
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
