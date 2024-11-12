import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var fo_current = useFolder()
    @State private var fi_current = useFile()
    @State private var alert = useAlert()
    @State private var search = useSearch()
    @State private var modal = useModal()

    @State var presentSearchBar: Bool = false

    
    var body: some View {
        
        NavigationView {
            VStack {
                //TODOO mieux implementer la recher mais y a de l'ide
//                VStack {
                    CSearch<File>(keyPath: \File.content, isPresented: search.boundIsPresented, reset: true)
                        .padding(.top, .xs)
                    SearchResults()
//                }
//                .background(.primary800)
//                .cornerRadius(.lg)
//                .padding(.md)


                DetailedFolderView()
            }

            // TOOLBAR FOLDER
            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
//            .toolbarBackgroundVisibility(.hidden)

            
        }


        .fullScreenModal(isPresented: isFileFormModalPresented) {
            FormFileView()
        }
        .fullScreenModal(isPresented: fo_current.boundEditing, color: .clear, drag: false) {
            FormFolderView()
        }
        .environment(fo_current)
        .environment(fi_current)
        .environment(alert)
        .environment(search)
        .environment(modal)
        .alert(alert.title, isPresented: alert.boundState) {
            alert.displayAction()
        } message: {
            alert.display()
        }
    }
    
    var isFileFormModalPresented: Binding<Bool> {
        Binding(
            get: { fi_current.boundEditing.wrappedValue && modal.current == .SearchModal },
            set: { newValue in
                fi_current.boundEditing.wrappedValue = newValue
            })
    }
    
    
}

#Preview {
    ContentView()
        .environment(useFolder())
        .environment(useFile())
        .environment(useAlert())
        .environment(useSearch())
        .environment(useModal())
        .modelContainer(for: Folder.self)
}
