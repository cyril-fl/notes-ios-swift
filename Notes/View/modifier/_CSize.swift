import SwiftUI

enum SpacingSize: CGFloat {
    case none = 0
    /// size : 4pt
    case xs = 4
    /// size : 8pt
    case sm = 8
    /// size : 12pt
    case md = 12
    /// size : 16pt
    case lg = 16
    /// size : 20pt
    case xl = 20
    /// size : 24pt
    case xl2 = 24
    /// size : 32pt
    case xl3 = 32
    /// size : 40pt
    case xl4 = 40
    /// size : 48pt
    case xl5 = 48
}

enum CornerRadiusSize: CGFloat {
    /// size : 0pt
    case none = 0
    /// size : 4pt
    case sm = 4
    /// size : 8pt
    case md = 8
    /// size : 12pt
    case lg = 12
    /// size : 16pt
    case xl = 16
    /// size : 24pt
    case xl2 = 24
    /// size : 32pt
    case xl3 = 32
    /// size : 9999pt ( Pour un cercle complet )
    case full = 9999
}

enum Size: CGFloat {
    /// size : 0pt
    case s0 = 0
    /// size : 4pt
    case s1 = 4
    /// size : 8pt
    case s2 = 8
    /// size :  12pt
    case s3 = 12
    /// size :  16pt
    case s4 = 16
    /// size :  20pt
    case s5 = 20
    /// size :  24pt
    case s6 = 24
    /// size :  28pt
    case s7 = 28
    /// size :  32pt
    case s8 = 32
    /// size :  36pt
    case s9 = 36
    /// size :  40pt
    case s10 = 40
    /// size :  44pt
    case s11 = 44
    /// size :  48pt
    case s12 = 48
    /// size :  52pt
    case s13 = 52
    /// size :  56pt
    case s14 = 56
    /// size :  60pt
    case s15 = 60
    /// size :  64pt
    case s16 = 64
    /// size :  68pt
    case s17 = 68
    /// size : 72pt
    case s18 = 72
    /// size : 76pt
    case s19 = 76
    /// size : 80pt
    case s20 = 80
    /// size : 84pt
    case s21 = 84
    /// size : 88pt
    case s22 = 88
    /// size : 92pt
    case s23 = 92
    /// size : 96pt
    case s24 = 96
    /// size : 104pt
    case s25 = 104
    /// size : 112pt
    case s26 = 112
    /// size : 120pt
    case s27 = 120
    /// size : 128pt
    case s28 = 128
    /// size : 136pt
    case s29 = 136
    /// size : 144pt
    case s30 = 144
    /// size : 152pt
    case s31 = 152
    /// size : 160pt
    case s32 = 160
    /// size : 168pt.
    case s33 = 168
    /// size : 176pt
    case s34 = 176
    /// size : 184pt
    case s35 = 184
    /// size : 192pt
    case s36 = 192
    /// size : 200pt
    case s37 = 200
    /// size : 208pt
    case s38 = 208
    /// size : 216pt
    case s39 = 216
    /// size : 224pt
    case s40 = 224
    /// size : 232pt
    case s41 = 232
    /// size : 240pt
    case s42 = 240
    /// size : 248pt
    case s43 = 248
    /// size : 256pt
    case s44 = 256
    /// size : 264pt
    case s45 = 264
    /// size : 272pt
    case s46 = 272
    /// size : 280pt
    case s47 = 280
    /// size : 288pt
    case s48 = 288
    /// size : 296pt
    case s49 = 296
    /// size : 304pt
    case s50 = 304
    /// size : 312pt
    case s51 = 312
    /// size : 320pt
    case s52 = 320
    /// size : 328pt
    case s53 = 328
    /// size : 336pt
    case s54 = 336
    /// size : 344pt
    case s55 = 344
    /// size : 352pt
    case s56 = 352
    /// size : 360pt
    case s57 = 360
    /// size : 368pt
    case s58 = 368
    /// size : 376pt
    case s59 = 376
    /// size : 384pt
    case s60 = 384
    /// size : 392pt
    case s61 = 392
    /// size : 400pt
    case s62 = 400
}


extension VStack {
    init(alignment: HorizontalAlignment = .center, spacing: SpacingSize, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

extension HStack {
    init(alignment: VerticalAlignment = .center, spacing: SpacingSize, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

extension LazyVGrid {
    init(
        columns: [GridItem] = [],
        spacing: SpacingSize = .none,
        pinnedViews: PinnedScrollableViews = [],
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            columns: columns,
            spacing: .init(spacing.rawValue),
            pinnedViews: pinnedViews,
            content: content
        )
    }
}

extension LazyHGrid {
    init(
        rows: [GridItem] = [],
        spacing: SpacingSize = .none,
        pinnedViews: PinnedScrollableViews = [],
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            rows: rows,
            spacing: .init(spacing.rawValue),
            pinnedViews: pinnedViews,
            content: content
        )
    }
}

extension View {
    // Frame
    func frame(maxWidth: Size? = nil, minHeight: Size? = nil, idealHeight: Size? = nil, maxHeight: Size? = nil, alignment: Alignment = .center) -> some View {
        self.frame(
            maxWidth: maxWidth?.rawValue,
            minHeight: minHeight?.rawValue,
            idealHeight: idealHeight?.rawValue,
            maxHeight: maxHeight?.rawValue,
            alignment: alignment
        )
    }
    
    func frame(width: Size? = nil, height: Size? = nil, alignment: Alignment = .center) -> some View {
        self.frame(
            width: width?.rawValue,
            height: height?.rawValue,
            alignment: alignment
        )
    }
    
    // Padding
    func padding(_ size: SpacingSize) -> some View {
        self.padding(size.rawValue)
    }

    func padding(_ edges: Edge.Set, _ size: SpacingSize) -> some View {
        self.padding(edges, size.rawValue)
    }
    
    // Corner Radius
    func cornerRadius(_ size: CornerRadiusSize) -> some View {
        self.cornerRadius(size.rawValue)
    }
}

