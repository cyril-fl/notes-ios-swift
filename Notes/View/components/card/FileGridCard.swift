import SwiftUI

struct FileGridCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @EnvironmentObject private var file : useFile

    private let key: UUID
    @State private var name: String
    @State private var content: String
    @State private var lastUpdateDate: Date
    @State private var isLoaded: Bool = false
    
    init(_ file: File) {
        self.key = file.id
        self._name = State(initialValue: file.name.isEmpty ? "Nouvelle note" : file.name)
        self._content = State(initialValue: file.content)
        self._lastUpdateDate = State(initialValue: file.lastUpdateDate)
    }
    
    var body: some View {
        HStack{
            VStack {
                Content

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
    
    var Content: some View {
        HStack(alignment: .top) {
            VStack {
                Text(content)
                    .font(.caption)
                Spacer()
            }
            Spacer()
        }
        .frame(width: 110, height: 80)
        .padding(10)
        .background(Color.secondary50)
        .cornerRadius(10)
    }
}
