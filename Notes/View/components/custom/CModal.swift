import SwiftUI
import UIKit

//TODO
// Reussi a se debarasser de FULLSCREENCOVER, pour gerer la transition seul, et mettre un sens pour le swipe.


enum ModalDirection {
    case up
    case down
}

struct CModal<Content: View>: View {
    var cornerRadius: CGFloat
    var backgroundColor: Color
    var closeDirection: ModalDirection
    var isDraggable: Bool
    var content: () -> Content
    
    
    @Environment(\.dismiss) var dismiss
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        ZStack {
            backgroundColor
                .cornerRadius(cornerRadius)
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(y: dragOffset.height)
                .animation(.linear, value: dragOffset.height) // Animation fluide
            
            self.content()
                .cornerRadius(cornerRadius)
                .offset(y: dragOffset.height) // Le contenu suit le déplacement
                .animation(.linear, value: dragOffset.height)
                .gesture(
                    isDraggable ?  DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            let _down = closeDirection == .down && value.location.y > value.startLocation.y
                            let _up = closeDirection == .up  && value.location.y < value.startLocation.y
                            
                            guard _down || _up else { return }
                            state = value.translation
                        }
                        .onEnded { value in
                            close(value.translation.height)
                        } : nil
                )
        }
    }
    
    private func close(_ value: CGFloat) {
        if closeDirection == .down && value > 150 {
            dismiss() // Fermer la modal quand la distance est suffisante
        } else if closeDirection == .up && value < -150 {
            dismiss()
        }
    }
}

struct CModalOverlay: View {
    var color: Color = .gray
    var opacity: Double = 0.6
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(color.opacity(opacity))
        .edgesIgnoringSafeArea(.all)
        .zIndex(30)
    }
}


extension View {
    func fullScreenModal<Content: View, OverlayContent: View>(
        isPresented: Binding<Bool>,
        isOverlayPresented: Bool = true,
        rounded: CGFloat = 25,
        color: Color = Color(.secondary100),
        direction: ModalDirection = .down,
        @ViewBuilder overlay: @escaping () -> OverlayContent = { CModalOverlay() },
        drag: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            if isPresented.wrappedValue && isOverlayPresented {
                overlay()
                    .scaleEffect(isPresented.wrappedValue ? 1.0 : 0.6) // Animation d'échelle de 90% à 100%
                    .opacity(isPresented.wrappedValue ? 1.0 : 0.0) // Opacité de 0 à 1
                    .animation(.easeIn(duration: 0.5), value: isPresented.wrappedValue) // Animation d'entrée
            }
            
            self
                .fullScreenCover(isPresented: isPresented) {
                    CModal(cornerRadius: rounded, backgroundColor: color, closeDirection: direction, isDraggable: drag) {
                        content() // Contenu de la modal
                    }
                    .presentationBackground(.clear)
                }
        }
    }
}
