import SwiftUI

enum Modal {
    case Neutral
    case EditModal
    case SearchModal
}

@Observable
class useModal: ObservableObject {
    private var _modal: Modal = .Neutral
    
    var current: Modal {
        get { _modal }
        set { _modal = newValue }
    }
}

