import SwiftUI

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
    /// size : 32pt | weight : bold | color : primary 700
    case h1
    /// To custumize
    case h2
    /// size : 16pt | weight : semibold | color : secondary 950
    case h3
    /// size : 12pt | weight : regular | color :  secondary 800
    case caption
    
    var font: Font {
        switch self {
        case .h1:
            return .system(size: FontSize.xl3.rawValue, weight: .bold, design: .default)
        case .h2:
            return .system(size: FontSize.xl.rawValue, weight: .bold, design: .default)
        case .h3:
            return .system(size: FontSize.base.rawValue, weight: .semibold, design: .default)
        case .caption:
            return  .system(size: FontSize.xs.rawValue, weight: .regular, design: .default)
        }
    }

    var color: Color {
        switch self {
        case .h1:
            return .primary700
        case .h2:
            return .gray
        case .h3:
            return .secondary950
        case .caption:
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
    func font(_ size: FontSize, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.font(.system(size: size.rawValue, weight: weight, design: design))
    }
    
    func font(_ style: FontStyle, color: Color? = nil) -> some View {
        let _color = color ?? style.color
        
        return self.font(style.font)
            .foregroundStyle(_color)
    }
    
}
