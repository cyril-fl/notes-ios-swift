import SwiftUI

enum ButtonType {
    case primary
    case secondary
}

struct ButtonUiMd: ViewModifier {
    var bgColor: Color
    
    init(_ bgColor: Color) {
        self.bgColor = bgColor
    }
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 45)
            .font(.headline)
            .background(bgColor)
            .cornerRadius(5)
    }
}

struct PrimaryButtonUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .foregroundStyle(.secondary50)
            .modifier(ButtonUiMd(.secondary900))
            .brightness(configuration.isPressed ? 0.2 : 0)
    }
}

struct SecondaryButtonUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .foregroundStyle(.secondary800)
            .modifier(ButtonUiMd(.secondary100))
            .brightness(configuration.isPressed ? 0.2 : 0)
    }
}

extension View {
    func buttonStyle(_ type: ButtonType) -> some View {
        switch type {
        case .primary:
            return AnyView(self.buttonStyle(PrimaryButtonUI()))
        case .secondary:
            return AnyView(self.buttonStyle(SecondaryButtonUI()))
        }
    }
}

extension ButtonStyle where Self == PrimaryButtonUI {
    static var primary: PrimaryButtonUI {
        PrimaryButtonUI()
    }
}

extension ButtonStyle where Self == SecondaryButtonUI {
    static var secondary: SecondaryButtonUI {
        SecondaryButtonUI()
    }
}
