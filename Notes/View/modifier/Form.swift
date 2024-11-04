import SwiftUI

struct EditForm: FormStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing:5) {
            configuration.content
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 25)
                .font(.title2)
        }
    }
}
