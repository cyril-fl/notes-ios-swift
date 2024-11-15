import SwiftUI

enum FileGridCardVariant {
    case base
    case search
}

// TODO: Refactor 
struct FileGridCard: View {
    @Environment(\.defaultFileName) private var defaultName
    @Environment(useFile.self) private var currentFile
    
    @Bindable var file: File
    @State var name: String = ""
    
    @State var content: String = ""
    
    var color: Color = .primary900
    var variant: FileGridCardVariant = .base
    
    var body: some View {
        VStack {
            card
        }
        .onAppear {
            handleInit()
        }
    }
        

    @ViewBuilder
    private var card: some View {
        switch variant {
        case .base:
            baseContent
        case .search:
            searchContent
        }
    }
    
    private var baseContent: some View {
        VStack {
            Thumbnail()
            Name
            UpdateDate
        }
        .background(Color(.systemBackground))
    }
    
    private var searchContent: some View {
        Thumbnail()
    }
    
    func Thumbnail() -> some View {
        HStack(alignment: .top) {
            VStack {
                Text(content)
                    .font(.caption)
                Spacer()
            }
            Spacer()
        }
        .frame(minHeight: 30)
        .frame(maxHeight: 120)
        .frame(maxWidth: 110)
        .padding(10)
        .background(.secondary100)
        .cornerRadius(10)
    }
    
    var Name: some View {
        Text(name)
            .font(.headline)
    }
    
    var UpdateDate: some View {
        Text("\(file.lastUpdateDate.formatted(date: .abbreviated, time: .shortened))")
            .font(.footnote)
            .foregroundStyle(.secondary500)
    }
    
    private func handleInit() {
        name = file.name.isEmpty ? defaultName : file.name
        content = file.content
    }
}
