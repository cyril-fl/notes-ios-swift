import SwiftUI

enum CBButtonSize{
    case xs
    case base
    case md
    case lg
}

struct CButton: View {
    let name: String
    let icon: String
    let style: ButtonType
    let size: CBButtonSize
    var isRounded: Bool
    @Binding var isLoading: Bool
    var isDisabled: Bool
    let action: () -> Void

    init(_ name: String = "",
         icon: String = "",
         style: ButtonType = .primary,
         size: CBButtonSize = .base,
         isRounded: Bool = false,
         isLoading: Binding<Bool> = .constant(false),
         isDisabled: Bool = false,
         action: @escaping () -> Void) {
        self.name = name
        self.icon = icon
        self.style = style
        self.size = size
        self.isRounded = isRounded
        self._isLoading = isLoading
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Content
        }
        .buttonStyle(style)
        .frame(
            idealWidth: self.frame.width,
            maxWidth: self.frame.maxWidth,
            idealHeight: self.frame.height,
            maxHeight: self.frame.height
        )
        .cornerRadius(isRounded ? frame.width : 0)
        .overlay(isDisabled ? Overlay  : nil)
        .disabled(isDisabled)
    }
    
    var frame: (width: CGFloat, height: CGFloat, maxWidth: CGFloat) {
        switch size {
        case .xs:
            return (width: 40, height: 40, maxWidth: 40)
        case .base:
            return (width: 200, height: 45, maxWidth: .infinity)  // Largeur maximale possible
        case .md:
            return (width: 100, height: 50, maxWidth: 150)
        case .lg:
            return (width: 150, height: 60, maxWidth: 200)
        }
    }
    
    var Content: some View {
        Group {
            if isLoading {
                CLoader("arrow.trianglehead.2.clockwise.rotate.90", isGradient: false, isAnimated: $isLoading)
                    
                    .padding(7)
            } else if !name.isEmpty && !icon.isEmpty {
                Label(name, systemImage: icon)
            } else if !icon.isEmpty {
                Image(systemName: icon)
            } else {
                Text(name)
            }
        }
    }
    
    
    var Overlay: some View {
        VStack {
            Color.secondary200
                .opacity(0.8)
        }
        .frame(width: isRounded ? 50 : nil, height: isRounded ? 50 : nil)
        .cornerRadius(isRounded ? 50 : 0)
    }
}

struct ContentView: View {
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            CButton("Delete", style: .primary, isLoading: $isLoading) {
                isLoading.toggle()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
