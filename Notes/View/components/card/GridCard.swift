import SwiftUI

// TODO: Refactor
struct GridCardLabel<T: ContentNode>: View {
    @Binding var item: T
    @State var name: String = ""
    var defaultName: String = "Untitled"
    

    var body: some View {
        VStack {
            Text("defaultName")
//            Name
//            UpdateDate
        }
        .onAppear {
//            handleInit()
        }
    }
    
//    var Name: some View {
//        Text(name)
//            .font(.caption)
//    }
    
//    var UpdateDate: some View {
//        Text("\(Item.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
//            .font(.caption)
//            .foregroundStyle(.secondary500)
//    }
//    
//    private func handleInit() {
//        name = Item.name.isEmpty ? defaultName : Item.name
//    }
}


struct GridCardPreview<Content: View>: View {
    var content: Content
    
    var body: some View {
        content
            .padding(10)
            .frame(maxWidth: 110, minHeight: 30, maxHeight: 120, alignment: .topLeading)
            .background(.secondary50)
            .cornerRadius(10)
    }
}
