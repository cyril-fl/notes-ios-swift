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

