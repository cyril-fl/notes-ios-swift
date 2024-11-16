import SwiftUI

struct HeaderLabel<Content: View>: View {
    let label: String
    let font: FontStyle
    let content: Content

    init(
        label: String,
        font: FontStyle = .h3,
        @ViewBuilder content: () -> Content = { EmptyView() }
    ) {
        self.label = label
        self.font = font
        self.content = content() // Appel immédiat de la closure
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .Cfont(font)
                Spacer()
                content
            }
        }
        .background(Color(.systemBackground))
    }
}
