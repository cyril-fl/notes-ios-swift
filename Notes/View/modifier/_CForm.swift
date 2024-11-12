import SwiftUI

struct ResetFormUI: FormStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing:7) {
            configuration.content
        }
        .padding(.top, 20)
        .padding(.bottom, 10)
        .padding(.horizontal, 18)
    }
}

struct PopUpFormUI: FormStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: .sm) {
            configuration.content
        }
        .padding(.vertical, .xl)
        .padding(.horizontal, .xl)
        .background(.secondary50.opacity(0.9))
        .cornerRadius(.xl)
        .padding(.horizontal, .xl5)
    }
}


struct TextEnhancedEditor: UIViewRepresentable {
    @Binding var text: String
    @Environment(\.textEditorForegroundColor) private var customForegroundColor
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = customForegroundColor
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.textColor = customForegroundColor
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextEnhancedEditor

        init(_ parent: TextEnhancedEditor) {
            self.parent = parent
        }
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

private struct TextEditorForegroundColorKey: EnvironmentKey {
    static let defaultValue: UIColor? = nil
}

extension EnvironmentValues {
    var textEditorForegroundColor: UIColor? {
        get { self[TextEditorForegroundColorKey.self] }
        set { self[TextEditorForegroundColorKey.self] = newValue }
    }
}

extension FormStyle where Self == ResetFormUI {
    static var reset: ResetFormUI {
        ResetFormUI()
    }
}
extension FormStyle where Self == PopUpFormUI {
    static var popup: PopUpFormUI {
        PopUpFormUI()
    }
}

extension View {
    func textEditorForegroundColor(_ color: UIColor) -> some View {
        self.environment(\.textEditorForegroundColor, color)
    }
}
