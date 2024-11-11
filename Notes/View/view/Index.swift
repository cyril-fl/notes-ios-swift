import SwiftUI
import SwiftData

struct Index: View {
    @StateObject private var fo_current = useFolder()
    @StateObject private var fi_current = useFile()
    @StateObject private var alert = useAlert()
    @StateObject private var search = useSearch()
    @StateObject private var modal = useModal()

    @State var presentSearchBar: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                CSearch<File>(keyPath: \File.content, isPresented: $presentSearchBar)
                SearchResults()
                DetailedFolderView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    toggleSearchButton
                }
            }
        }
        .fullScreenModal(isPresented: isFileFormModalPresented) {
            FormFileView()
        }
        .fullScreenModal(isPresented: fo_current.boundEditing, color: .clear, drag: false) {
            FormFolderView()
        }
        .environmentObject(fo_current)
        .environmentObject(fi_current)
        .environmentObject(alert)
        .environmentObject(search)
        .environmentObject(modal)
        .alert(alert.title, isPresented: alert.boundState) {
            alert.displayAction()
        } message: {
            alert.display()
        }
    }

    var toggleSearchButton: some View {
        Group {
            if !presentSearchBar {
                CButton("", icon: "magnifyingglass", style: .accent, size: .xs) {
                    presentSearchBar.toggle()
                }
                .animation(.easeInOut, value: presentSearchBar)
            }
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
