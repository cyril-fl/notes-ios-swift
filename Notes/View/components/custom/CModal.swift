import SwiftUI

import SwiftUI


struct CModal: View {
    @EnvironmentObject var modalContent: useModal // L'environnement contient le contenu

    var body: some View {
        ZStack {
            // Si un contenu est défini dans modalContent, il sera affiché ici
            if let content = modalContent.content {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
        }
    }
}
