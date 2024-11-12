import SwiftUI
import SwiftData

//struct ContentViewV1: View {
//    @State var presentSearchBar: Bool = false
//
//    var body: some View {
//
//        NavigationView {
//            VStack {
////                //TODOO mieux implementer la recher mais y a de l'ide
//////                VStack {
////                    CSearch<File>(keyPath: \File.content, isPresented: search.boundIsPresented, reset: true)
////                        .padding(.top, .xs)
////                    SearchResults()
//////                }
//////                .background(.primary800)
//////                .cornerRadius(.lg)
//////                .padding(.md)
//
//
//                DetailedFolderView()
//            }
//
//            // TOOLBAR FOLDER
////            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
////            .toolbarBackgroundVisibility(.hidden)
//
//
//        }
//
//


//
//    }
//
//    var isFileFormModalPresented: Binding<Bool> {
//        Binding(
//            get: { fi_current.boundEditing.wrappedValue && modal.current == .SearchModal },
//            set: { newValue in
//                fi_current.boundEditing.wrappedValue = newValue
//            })
//    }
//
//
//}


struct ContentView: View {
    @Bindable var alert: useAlert
    @Bindable var file: useFile
    @Bindable var folder: useFolder
    @Bindable var search: useSearch
    
    
    var body: some View {
        NavigationView {
            
            
//            CSearch<File>(keyPath: \File.content, isPresented: $search.present, reset: true)
//                .padding(.top, .xs)
//            SearchResults()
        

            
            ContentFoldersView()
        }
        .fullScreenModal(isPresented: $folder.editing, color: .clear, drag: false) {
            FormFolderView()
        }
        .alert(alert.title, isPresented: $alert.state) {
            alert.displayAction()
        } message: {
            alert.display()
        }
    }
}


    #Preview {
        ContentView(alert: useAlert(), file: useFile(), folder: useFolder(), search: useSearch())
            .environment(useFolder())
            .environment(useFile())
            .environment(useAlert())
            .environment(useSearch())
            .environment(useModal())
            .modelContainer(for: Folder.self)
    }
