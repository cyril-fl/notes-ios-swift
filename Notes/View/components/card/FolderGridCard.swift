import SwiftUI

struct FolderGridCard: View {
    var _f: Folder
    
    init(_ _f: Folder) {
        self._f = _f
    }
    
    var body: some View {
        HStack{
            VStack {
                Image(systemName: "folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.secondary800)
                Text(_f.name)
                    .font(.headline)
                
                Group {
                    Text("\(_f.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                }
                .foregroundStyle(.secondary500)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground)) // TODO : Supprimer  quand j'aurais gerer l'élément de survol.
    }
}
