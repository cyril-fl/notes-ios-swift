import SwiftUI

struct HeaderButtonList: View {
    @Binding var display: DisplayMode
    var addAction: () -> Void
    
    var body: some View {
        HStack {
            ForEach(actionListItems, id: \.icon) { item in
                Button(action: item.action) {
                    Image(systemName: item.icon)
                }
            }
        }
    }

    private func toggleViewMode() {
        withAnimation {
            display.toggle()
        }
    }
    private var actionListItems: [IconAction] {
        [
            (icon: toggleIcon, action: toggleViewMode),
            (icon: "plus", action: addAction)
        ]
    }
    
    private var toggleIcon: String {
        display == .list ? "square.grid.2x2" : "list.bullet"
    }
}
