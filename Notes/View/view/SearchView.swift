import SwiftUI
import SwiftData

struct SearchView: View {
    @Query var files: [File]

    init(_ query : String) {
        _files = Query(filter: #Predicate<File> { file in
            file.content.contains(query)
        }, animation: .easeIn)
    }
 
    var body: some View {
        if files.isEmpty {
            Text("No files found")
        } else {
            ForEach(files) { file in
                Text(file.name)
            }
        }
    }
}



