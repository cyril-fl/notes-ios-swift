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
    
    var color: Color = .primary400
    var variant: FileGridCardVariant = .base
    
    var body: some View {
        VStack {
            contentView
        }
        .onAppear {
            name = name.isEmpty ? defaultName : name
        }
        .onChange(of: currentFile.current) {
            name = currentFile.name.isEmpty ? defaultName : currentFile.name
        }
        .onChange(of: currentFile.editing) {
            if !currentFile.editing {
                updateView()
            }
        }
    }
    
    private var contentView: some View {
        Group {
            switch variant {
            case .base:
                baseContent
            case .search:
                searchContent
            }
        }
    }
    
    private var baseContent: some View {
        VStack {
            Thumbnail(maxHeight: 80)
            Name
            UpdateDate
        }
        .background(Color(.systemBackground))
    }
    
    private var searchContent: some View {
        Thumbnail(maxHeight: .infinity)
    }
    
    func Thumbnail(maxHeight: CGFloat) -> some View {
        HStack(alignment: .top) {
            VStack {
                Text(content)
                    .font(.caption)
                Spacer()
            }
            Spacer()
        }
        .frame(minHeight: 30)
        .frame(width: 110)
        .frame(maxHeight: maxHeight)
        .padding(10)
        .background(color)
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
    
    private func updateView() {
        name = currentFile.name
        content = currentFile.content
    }
}
