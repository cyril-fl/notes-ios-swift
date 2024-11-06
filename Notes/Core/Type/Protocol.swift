import SwiftUI

protocol Named {
    var name: String { get }
}
protocol Iconed {
    var icon: String { get }
}
protocol Roled {
    var role: ButtonRole { get }
}
protocol Styled {
    var style: ButtonType { get }
}
protocol Action {
    var action: () -> Void { get }
}
protocol Colored {
    var color: Color { get }
}
