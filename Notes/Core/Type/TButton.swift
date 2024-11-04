import SwiftUI

typealias IconButtonType = (
    icon: String,
    action: () -> Void
)

typealias RoleButtonType = (
    label: String,
    role: ButtonRole,
    action: () -> Void
)

typealias StyledButtonType = (
    label: String,
    style: ButtonType,
    action: () -> Void
)

typealias SwipeButtonType = (
    label: String,
    icon: String,
    color: Color,
    action: () -> Void
)
