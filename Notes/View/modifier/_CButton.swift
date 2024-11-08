import SwiftUI

enum ButtonType {
    case primary
    case secondary
    case accent
    case disable
}

struct ButtonUiMd: ViewModifier {
    var bgColor: Color
    
    init(_ bgColor: Color) {
        self.bgColor = bgColor
    }
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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

struct AccentButtonUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .foregroundStyle(.accent)
    }
}

struct DisableButtonUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .foregroundStyle(.secondary400)
            .modifier(ButtonUiMd(.secondary100))
            .disabled(true)
    }
}

extension View {
    func buttonStyle(_ type: ButtonType) -> some View {
        switch type {
        case .primary:
            return AnyView(self.buttonStyle(PrimaryButtonUI()))
        case .secondary:
            return AnyView(self.buttonStyle(SecondaryButtonUI()))
        case .accent:
            return AnyView(self.buttonStyle(AccentButtonUI()))
        case .disable:
            return AnyView(self.buttonStyle(DisableButtonUI()))
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
