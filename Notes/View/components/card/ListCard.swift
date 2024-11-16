import SwiftUI

struct ListCard<T: ContentNode, Content: View, Description: View>: View {
    @Environment(\.defaultName) private var defaultName
    @Environment(\.defaultItemKey) private var currentItem

    @ObservedObject var item: T
    @State private var title: String = ""
    
    var aside: Content
    var descriptionView: Description

    init(
        item: T,
        @ViewBuilder aside: () -> Content = { EmptyView() },
        @ViewBuilder descriptionContent: () -> Description = { EmptyView() }
    ) {
        self.item = item
        self.aside = aside()
        self.descriptionView = descriptionContent()
    }

    var body: some View {
        LabeledContent {
            asideContent
        } label: {
            VStack(alignment: .leading) {
                labelContent
                descriptionContent
                dateContent
            }
        }
        .onAppear(perform: handleInit)
        .onChange(of: defaultName, initial: true, handleInit)
        .onChange(of: currentItem!.editing, initial: true, handleUpdate)
    }
    


    var labelContent: some View {
        Text(title)
            .Cfont(.h4)
            .lineLimit(1)
    }

    @ViewBuilder
    var descriptionContent: some View {
        if descriptionView is EmptyView {
            EmptyView()
        } else {
            descriptionView
        }
    }

    @ViewBuilder
    var asideContent: some View {
        if aside is EmptyView {
            EmptyView()
        } else {
            HStack {
                aside
            }
            .Cfont(.h5, color: .secondary500)
        }
    }

    var dateContent: some View {
        Text(item.lastUpdateDate.formatted(.dateTime))
            .Cfont(.h6, color: .primary700)
            .lineLimit(2)
    }

    private func handleInit() {
        title = item.name.isEmpty ? defaultName : item.name
    }
    
    private func handleUpdate() {
        guard currentItem?.editing == false else { return }
        title = item.name
    }
    
    func defineDescriptionContent<NewDescription: View>(@ViewBuilder content: () -> NewDescription) -> ListCard<T, Content, NewDescription> {
        ListCard<T, Content, NewDescription>(item: item, aside: { aside }, descriptionContent: content)
    }

    func defineAsideContent<NewAside: View>(@ViewBuilder content: () -> NewAside) -> ListCard<T, NewAside, Description> {
        ListCard<T, NewAside, Description>(item: item, aside: content, descriptionContent: { descriptionView })
    }
}
