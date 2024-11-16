import SwiftUI
import SwiftData

struct BreadCrumbs<T: ContentNode & UUIDentifiable> : View {
    @Query() private var folders : [Folder]
    @State private var path = usePath<Folder>()
    
    var item : T

    var body: some View {
        Text(path.formatted(item.path +  [item.id]))
            .Cfont(.h6)
            .onAppear(perform: handleInit)
    }
    
    func handleInit() {
        path.item = folders
    }
}
