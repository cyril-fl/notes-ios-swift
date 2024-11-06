import Foundation
import SwiftUI
import Observation

@Observable
final class useAlert: ObservableObject {
    private var _isAlert: Bool = false
    private var _title: String = ""
    private var _message: String = ""
    private var _action: [RoleButtonInterface] = []
    

    var isPresented: Bool {
        get {_isAlert}
        set {_isAlert = newValue}
    }
    var title: String {
        get {_title}
        set {_title = newValue}
    }
    var message: String {
        get {_message}
        set { _message = newValue }
    }
    var actions: [RoleButtonInterface] {
        get {_action}
        set {_action = newValue}
    }
    var boundState: Binding<Bool> {
        Binding(
            get: { self._isAlert },
            set: { self._isAlert = $0 }
        )
    }
    
    func displayAction() -> some View {
        ForEach(actions, id: \.name) { a in
            Button(a.name, role: a.role, action: a.action)
        }
    }
    
    func display() -> some View {
        VStack(alignment: .leading) {
                Text(_message)
        }
    }
}
