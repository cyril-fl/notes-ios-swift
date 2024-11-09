import SwiftUI

struct HeaderButtonList: View {
    @EnvironmentObject var display : useDisplay
//    @Binding var display: DisplayMode
    
    var add: () -> Void
    
    var body: some View {
        HStack {
            ForEach(listedAction, id: \.icon) { item in
                CButton(item.icon, icon: item.icon, style: .accent, size: .xs ,action: item.action)
            }
        }
    }

    private var listedAction: [IconButtonInterface] {
        [
            IconButtonInterface(icon: toggledIcon, action: toggleViewMode),
            IconButtonInterface(icon: "plus", action: add)
        ]
    }
    
    private func toggleViewMode() {
        withAnimation {
            display.mode.toggle()
        }
    }
    
    private var toggledIcon: String {
        display.mode == .list ? "square.grid.2x2" : "list.bullet"
    }
}
