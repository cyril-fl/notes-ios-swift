import SwiftUI
import SwiftData

@main
struct NotesApp: App {
//    @StateObject var CModals = useModal() // L'objet global contenant le contenu modal
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                IndexView()
//                    .border(.accent)
                    .modelContainer(for: Folder.self)
                
//                CModal()
            }
//            .environmentObject(CModals) // Injecter l'EnvironmentObject ici
//            .onAppear {
//                // Définir le contenu à afficher dans la fenêtre modale
//                CModals.content = AnyView(EmptyView())
//            }
        }
    }
}
