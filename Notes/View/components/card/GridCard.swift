import SwiftUI

struct GridCardLabel<T: ContentNode>: View {
    @Environment(\.defaultName) private var defaultName
    @Environment(\.defaultItemKey) private var currentItem
    
    @ObservedObject var item: T
    @State var title: String = ""
    
    var body: some View {
        VStack {
            label
            date
        }
        .onAppear(perform: handleInit)
        .onChange(of: defaultName, initial: true, handleInit)
        .onChange(of: currentItem!.editing, initial: true, handleUpdate)
    }
    
    var label: some View {
        Text(title)
            .font(.caption)
    }
    
    var date: some View {
        Text(item.lastUpdateDate)
            .font(.caption)
            .foregroundStyle(.secondary500)
    }
    
    private func handleInit() {
        title = item.name.isEmpty ? defaultName : item.name
    }
    
    private func handleUpdate() {
        guard currentItem?.editing == false else { return }
        title = item.name
    }
}

struct GridCardPreview<Content: View>: View {
    var content: Content
    var idealH: Size?
    
    init(idealH: Size? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.idealH = idealH
    }
    
    var body: some View {
        content
            .padding(.md)
            .frame(maxWidth: .s26, minHeight: .s8, idealHeight: idealH, maxHeight: .s22, alignment: .topLeading)
            .background(.secondary50)
            .cornerRadius(.lg)
    }
}
