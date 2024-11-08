import SwiftUI

struct ScreenColorOverlay: View {
    var color: Color = .gray
    var opacity: Double = 0.6
    
    var body: some View {
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color.opacity(opacity))
        }
}
