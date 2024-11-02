import SwiftUI

typealias IconAction = (
    icon: String,
    action: () -> Void
)

typealias LabelAction = (
    label: String,
    action: () -> Void,
    style: ButtonType
)

typealias ActionItem = (
    label: String,
    icon: String,
    color: Color,
    action: () -> Void
)
