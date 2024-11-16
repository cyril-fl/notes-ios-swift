import SwiftUI

protocol ContentNode: ObservableObject  {
    var name: String { get set}
    var path: String { get  set}
    var lastUpdateDate: Date { get set }
}

protocol Editable {
    var editing: Bool { get set }
}
