import SwiftUI

struct ListCard<T: ContentNode & Observable, Content: View, Description: View>: View {
 var item: T
    var aside: Content
    var descriptionView: Description

    @State private var label: String = "Nouveau dossier"

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
            VStack(alignment: .leading, spacing: .xs) {
                labelContent
                descriptionContent
                dateContent
            }
        }
        .onAppear(perform: handleAppear)
        .onDisappear(perform: handleUpdate)
        

    }
    


    var labelContent: some View {
        Text(label)
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

    private func handleAppear() {
        label = item.name.isEmpty ? "defaultName" : item.name
    }
    
    private func handleUpdate() -> Void {
        label = item.name != label ? item.name : label;
    }
    
    func defineDescriptionContent<NewDescription: View>(@ViewBuilder content: () -> NewDescription) -> ListCard<T, Content, NewDescription> {
        ListCard<T, Content, NewDescription>(item: item, aside: { aside }, descriptionContent: content)
    }

    func defineAsideContent<NewAside: View>(@ViewBuilder content: () -> NewAside) -> ListCard<T, NewAside, Description> {
        ListCard<T, NewAside, Description>(item: item, aside: content, descriptionContent: { descriptionView })
    }
}

#Preview {
    let temp = File(name: "Document", path: "/")

    ListCard(item: temp)
        .defineDescriptionContent { Text(temp.name) }
        .defineAsideContent { Text("Détails supplémentaires") }
}
