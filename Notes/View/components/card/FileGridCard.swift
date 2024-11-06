import SwiftUI

struct FileGridCard: View {
    var _f: File
    
    init(_ file: File) {
        self._f = file
    }
    
    var body: some View {
        HStack{
            VStack {
                Content

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
    
    var Content: some View {
        HStack(alignment: .top) {
            VStack {
                Text(_f.content)
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
