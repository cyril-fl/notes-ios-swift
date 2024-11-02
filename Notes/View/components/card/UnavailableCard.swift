import SwiftUI

struct UnavailableCard: View {
    var label: String
    var icon: String
    
    var body: some View {
        ContentUnavailableView(
            "No \(label) found",
            systemImage: icon,
            description: Text("Need to add some \(label).")
        )
    }
}
