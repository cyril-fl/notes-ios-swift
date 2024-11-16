import SwiftUI

struct CLoader: View {
    private let icon: String
    private let gradient: Bool
    private let color: Color
    private let speed: Double
    @Binding private var isAnimated: Bool
    
    @State private var rotate: Double = 0

    init(
        _ icon: String = "circle.dotted",
        speed: Double = 0.4,
        color: Color = .secondary50,
        isGradient: Bool = true,
        isAnimated: Binding<Bool> = .constant(false)
    ) {
        self.icon = icon
        self.speed = speed
        self.color = color
        self.gradient = isGradient
        self._isAnimated = isAnimated
    }
    
    private var rotationAnimation: Animation {
        .linear(duration: 1)
            .speed(speed)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View  {
        if isAnimated {
            Circle()
                .foregroundStyle(foreground)
                .mask {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                }
                .rotationEffect(.degrees(rotate))
                .onAppear {
                    withAnimation(rotationAnimation) {  // Utilisation de rotationAnimation
                        rotate = 360.0
                    }
                }
                .onDisappear {
                    rotate = 0
                }
        }
    }
    
    private var foreground: some ShapeStyle {
        let colors: [Color] = gradient ? [
            color.opacity(0.2),
            color.opacity(0.3),
            color.opacity(0.75),
            color
        ] : [color]
        
        return AngularGradient(
            gradient: Gradient(colors: colors),
            center: .center,
            angle: .degrees(360)
        )
    }
}
