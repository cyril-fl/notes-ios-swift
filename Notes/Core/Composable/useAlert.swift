import Foundation
import SwiftUI
import Observation

@Observable
final class useAlert {
    var state: Bool = false
    var title: String = ""
    var message: String = ""
    var actions: [RoleButtonInterface] = []

    
    func displayAction() -> some View {
        ForEach(actions, id: \.name) { a in
            CButton(a.name, action: a.action)
        }
    }
    
    func display() -> some View {
        VStack(alignment: .leading) {
                Text(_message)
        }
    }
}
