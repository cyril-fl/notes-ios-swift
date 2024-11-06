import SwiftUI

// Struc
struct IconButtonInterface: Iconed, Action {
    let icon: String
    let action: () -> Void
}

struct RoleButtonInterface: Named, Roled, Action {
    let name: String
    let role: ButtonRole
    let action: () -> Void
    
    init(_ name: String, role: ButtonRole, action: @escaping () -> Void) {
        self.name = name
        self.role = role
        self.action = action
    }
}

struct StyledButtonInterface: Named, Styled, Action {
    let name: String
    var style: ButtonType
    var action: () -> Void
    
    init(_ name: String, style: ButtonType, action: @escaping () -> Void) {
        self.name = name
        self.style = style
        self.action = action
    }
}

struct SwipeButtonInterface: Named, Iconed, Colored, Action {
    let name: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    init(_ name: String, icon: String, color: Color, action: @escaping () -> Void) {
        self.name = name
        self.icon = icon
        self.color = color
        self.action = action
    }
}
