import SwiftUI

//enum ListStyle {
//    case base
//}
//
//struct ListDefault: ViewModifier {
//    var bgColor: Color
//    
//    init(_ bgColor: Color) {
//        self.bgColor = bgColor
//    }
//    
//    func body(content: Content) -> some View {
//        content
//            .listStyle(.plain)
//        
//        
//        
//        
//    }
//}
//
//
//extension View {
//    func listStyle(_ style : ListStyle) -> some View {
//        switch style {
//        case .base:
//            self.modifier(ListDefault(.white))
//        }
//    }
//}



struct ListFolderView: View {
    @Environment(useFolder.self) private var folder
    @Environment(useSearch.self) private var search
    var folders: [Folder]
    
    @State var presentSearchBar: Bool = false

    
    var body: some View {
        List {
            Section(header: Header) {
                ForEach(folders, id: \.id) { _folder in
                    NavigationLink(destination: DetailedFileView()
                        .onAppear {
                            folder.current = _folder
                        }
                    ) {
                        FolderListCard(_folder)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        ActionFolderView(_folder)
                    }
                }
                
            }
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden) 
    }
    
    
    private var Header: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dossiers")
                    .font(.h1)
                Spacer()
                toggleSearchButton
            }
        }
        .padding(.horizontal)
        .background()
        .listRowInsets(EdgeInsets())
    }
    
    var toggleSearchButton: some View {
        Group {
            if !presentSearchBar {
                CButton("", icon: "magnifyingglass", style: .accent, size: .xs) {
                    search._isPresented.toggle()
                }
                .animation(.easeInOut, value: presentSearchBar)
            }
        }
    }
}
