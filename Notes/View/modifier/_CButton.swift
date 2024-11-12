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
            .frame(maxWidth: .infinity)
            .padding(.vertical, .md)
            .fontSize(.sm)
            .background(bgColor)
    }
}

struct PrimaryButtonUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .foregroundStyle(
                isActive(configuration, base: .secondary50, pressed: .primary50)
            )
            .modifier(ButtonUiMd(
                isActive(configuration, base: .primary700, pressed: .primary600)
            ))
            .fontWeight(.semibold)
            .roundedBorder(
                isActive(configuration, base: .primary700, pressed: .primary700), width: 2, cornerRadius: 5)
            .animation(.easeIn(duration: 0.25), value: configuration.isPressed)
    }
}

struct SecondaryButtonUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .foregroundStyle(
                isActive(configuration, base: .secondary400, pressed: .secondary300)
            )
            .modifier(ButtonUiMd(
                isActive(configuration, base: .secondary100, pressed: .secondary50)
            ))
            .fontWeight(.medium)
            .roundedBorder(
                isActive(configuration, base: .secondary100, pressed: .secondary200), width: 2, cornerRadius: 5)
            .animation(.easeIn(duration: 0.25), value: configuration.isPressed)
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
    // Button
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
    
    // RoundeBorder
    // TODO regarder pour faire pareil "surchage de fonction" la ou c'est faisable dans les extensions
    func roundedBorder(_ color: Color, width: CGFloat, cornerRadius: CGFloat = 5) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: width)
        )
        .cornerRadius(cornerRadius)
    }
    func roundedBorder(_ color: Color, width: CGFloat, cornerRadius: CornerRadiusSize = .none) -> some View {
        roundedBorder(color, width: width, cornerRadius: cornerRadius.rawValue)
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

extension ButtonStyle {
    func isActive(_ configuration: Configuration, base: Color, pressed: Color) -> Color {
        if configuration.isPressed {
            return pressed
        }
        return base
    }
}

