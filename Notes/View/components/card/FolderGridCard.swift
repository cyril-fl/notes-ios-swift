import SwiftUI

struct FolderGridCard: View {
    var _f: Folder
    
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
//                    Text("Path: \(folder.path)")
//                        .font(.subheadline)
                    Text("\(_f.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                }
                .foregroundStyle(.secondary500)

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
