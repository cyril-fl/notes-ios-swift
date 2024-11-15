import SwiftUI

#Preview("Title h1 - h6") {
    Text("Hello, World!")
        .Cfont(.h1)
    Text("Hello, World!")
        .Cfont(.h2)
    Text("Hello, World!")
        .Cfont(.h3)
    Text("Hello, World!")
        .Cfont(.h4)
    Text("Hello, World!")
        .Cfont(.h5)
    Text("Hello, World!")
        .Cfont(.h6)
}

enum FontSize: CGFloat {
    ///  size :  12pt
    case xs = 12
    /// size :  14pt
    case sm = 14
    /// size :  16pt
    case base = 16
    /// size :  18pt
    case lg = 18
    /// size :  20pt
    case xl = 20
    /// size :  24pt
    case xl2 = 24
    /// size :  30pt
    case xl3 = 30
    /// size :  36pt
    case xl4 = 36
    /// size :  48pt
    case xl5 = 48
    /// size :  60pt
    case xl6 = 60
}

enum FontStyle {
    /// size : 36pt | weight : heavy | color : primary 700
    case h1
    /// size : 30pt | weight : bold | color : primary 700
    case h2
    /// size : 20pt | weight : bold | color : primary 600
    case h3
    /// size : 16pt | weight : semibold | color : secondary 950
    case h4
    /// size : 14pt | weight : medium | color :  secondary 800
    case h5
    /// size : 12pt | weight : regular | color :  secondary 800
    case h6
    
    var font: Font {
        switch self {
        case .h1:
            return .system(size: FontSize.xl4.rawValue, weight: .heavy, design: .default)
        case .h2:
            return .system(size: FontSize.xl3.rawValue, weight: .bold, design: .default)
        case .h3:
            return .system(size: FontSize.xl.rawValue, weight: .bold, design: .default)
        case .h4:
            return .system(size: FontSize.base.rawValue, weight: .semibold, design: .default)
        case .h5:
            return  .system(size: FontSize.sm.rawValue, weight: .medium, design: .default)
        case .h6:
            return  .system(size: FontSize.xs.rawValue, weight: .regular, design: .default)
        }
    }

    var color: Color {
        switch self {
        case .h1:
            return .primary700
        case .h2:
            return .primary700
        case .h3:
            return .primary600
        case .h4:
            return .secondary950
        case .h5:
            return .secondary900
        case .h6:
            return .secondary800
        }
    }
}


extension View {
    // Size
    func fontSize(_ size: FontSize, weight: Font.Weight = .regular) -> some View {
        self.font(.system(size: size.rawValue, weight: weight))
    }
    
    //Style
    func Cfont(_ size: FontSize, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.font(.system(size: size.rawValue, weight: weight, design: design))
    }
    
    func Cfont(_ style: FontStyle, color: Color? = nil) -> some View {
        let _color = color ?? style.color
        
        return self.font(style.font)
            .foregroundStyle(_color)
    }
    
}
