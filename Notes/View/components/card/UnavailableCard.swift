import SwiftUI

struct UnavailableCard: View {
    var title: String
    var message: String
    var icon: String
    
    var body: some View {
        ContentUnavailableView(
            title,
            systemImage: icon,
            description: Text(message)
        )
    }
}
