import SwiftUI

struct WindowBis<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // Vue qui s'affiche dans la fenêtre
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white) // Vous pouvez personnaliser l'apparence de votre fenêtre ici
                .cornerRadius(20)
                .shadow(radius: 10)
        }
    }
}
