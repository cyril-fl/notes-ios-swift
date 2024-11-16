import SwiftUI

enum InputStyle {
    case search
}


struct SearchFieldUi: ViewModifier {
    var bgColor: Color
    var accentColor: Color = .primary600
    var disableColor: Color = .secondary200
    var reset: Bool
    @Binding var query: String
    
    init(_ bgColor: Color, query: Binding<String>, reset: Bool) {
        self.bgColor = bgColor
        self._query = query
        self.reset = reset
    }
    
    func body(content: Content) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(accentColor)
            content
            
            if reset {
                Button {
                    query = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(query.isEmpty ? disableColor : accentColor)
                }
            }
        }
        .padding(10)
        .background(bgColor)
        .cornerRadius(10)
    }
}

struct SearchFormUI: FormStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .sm) {
            configuration.content
        }
        .padding(.vertical, .md)
        .padding(.horizontal, .lg)
    }
}

extension TextField {
    func inputStyle(_ type: InputStyle, color: Color = .secondary50) -> some View {
        switch type {
        case .search:
            return AnyView(self.modifier(SearchFieldUi(color,query: .constant(""), reset: false)))
        }
    }
}

extension TextField {
    func inputStyle(
        _ type: InputStyle,
        color: Color = .secondary50,
        reset: Bool = false,
        _ linked: Binding<String>? = nil
    ) -> some View {
        switch type {
        case .search:
            return AnyView(self.modifier(SearchFieldUi(color,query: linked ?? .constant(""), reset: reset)))        }
    }
}

extension FormStyle where Self == SearchFormUI {
    static var search: SearchFormUI {
        SearchFormUI()
    }
}
