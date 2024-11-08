import SwiftUI
import UIKit

struct CModal<Content: View>: View {
    var cornerRadius: CGFloat
    var backgroundColor: Color
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
                .animation(.linear, value: dragOffset.height)
            
            self.content()
                .cornerRadius(cornerRadius)
                .offset(y: dragOffset.height)
                .animation(.linear, value: dragOffset.height)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation // Suivi du mouvement du doigt
                        }
                        .onEnded { value in
                            // Si le drag dépasse une certaine distance, fermer la modal
                            if value.translation.height > 150 {
                                dismiss() // Ferme la modal
                            }
                        }
                )
        }
    }
}

extension View {
    func fullScreenModal<Content: View>(
        isPresented: Binding<Bool>,
        rounded: CGFloat = 25,
        color: Color = Color(.systemGroupedBackground),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.fullScreenCover(isPresented: isPresented) {
            CModal(cornerRadius: rounded, backgroundColor: color) {
                content() // Contenu de la modal
            }
            .presentationBackground(.clear)
        }
    }
}
