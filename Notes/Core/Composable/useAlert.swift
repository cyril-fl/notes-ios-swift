import Foundation
import SwiftUI
import Observation

@Observable
final class useAlert {
    var state: Bool = false
    var title: String = ""
    var message: String = ""
    var actions: [AlertAction] = []

    
    func displayAction() -> some View {
        ForEach(actions, id: \.label) { a in
            CButton(a.label, action: a.action)
        }
    }
    
    func display() -> some View {
        VStack(alignment: .leading) {
                Text(_message)
        }
    }
}
