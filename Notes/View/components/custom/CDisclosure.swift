import SwiftUI

struct CDisclosure: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        if configuration.isExpanded {
            configuration.content
        }
    }
}
