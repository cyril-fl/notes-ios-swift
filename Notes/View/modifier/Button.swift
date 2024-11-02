import SwiftUI

enum ButtonType {
    case primary
    case secondary
    case success
    case danger
}

typealias ButtonStyleAttributes = (
    backgroundColor: Color,
    foregroundStyle: Color,
    cornerRadius: CGFloat,
    maxWidth: CGFloat,
    maxHeight: CGFloat,
    horizontalPadding: CGFloat,
    bottomPadding: CGFloat,
    font: Font
)

struct _ButtonUI: ViewModifier {
    var backgroundColor: Color
    var foregroundStyle: Color
    var cornerRadius: CGFloat
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    var horizontalPadding: CGFloat
    var bottomPadding: CGFloat
    var font: Font
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            .background(backgroundColor)
            .foregroundStyle(foregroundStyle)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .padding(.horizontal, horizontalPadding)
            .padding(.bottom, bottomPadding)
            .font(font) // Applique le style de police ici
    }
}

struct ButtonUI: ButtonStyle {
    var type: ButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        let style = getButtonStyle(for: type)
        
        return configuration.label
            .modifier(
                _ButtonUI(
                    backgroundColor: style.backgroundColor,
                    foregroundStyle: style.foregroundStyle,
                    cornerRadius: style.cornerRadius,
                    maxWidth: style.maxWidth,
                    maxHeight: style.maxHeight,
                    horizontalPadding: style.horizontalPadding,
                    bottomPadding: style.bottomPadding,
                    font: style.font
                )
            )
            .brightness(configuration.isPressed ? 0.2 : 0)
    }
    
    private func getButtonStyle(for type: ButtonType) -> ButtonStyleAttributes {
        switch type {
        case .primary:
            return (
                backgroundColor: .secondary950,
                foregroundStyle: .secondary50,
                cornerRadius: 7,
                maxWidth: .infinity,
                maxHeight: 48,
                horizontalPadding: 0,
                bottomPadding: 0,
                font: .headline
            )
        case .secondary:
            return (
                backgroundColor: .secondary600,
                foregroundStyle: .secondary50,
                cornerRadius: 7,
                maxWidth: .infinity,
                maxHeight: 48,
                horizontalPadding: 0,
                bottomPadding: 0,
                font: .headline
            )
        case .success:
            return (
                backgroundColor: .green,
                foregroundStyle: .white,
                cornerRadius: 25,
                maxWidth: .infinity,
                maxHeight: 60,
                horizontalPadding: 15,
                bottomPadding: 5,
                font: .headline
            )
        case .danger:
            return (
                backgroundColor: .red,
                foregroundStyle: .white,
                cornerRadius: 25,
                maxWidth: .infinity,
                maxHeight: 60,
                horizontalPadding: 15,
                bottomPadding: 5,
                font: .headline
            )
        }
    }
}

extension View {
    func buttonStyle(_ type: ButtonType) -> some View {
        self.buttonStyle(ButtonUI(type: type))
    }
}

#Preview {
    let function: () -> Void = {}
    
    HStack {
        Button(action: function) {
            Text("Annuler")
        }
        .buttonStyle(.secondary)
        
        Button(action: function) {
            Text("Enregistrer")
        }
        .buttonStyle(.primary)
    }
    .padding(10)
}

