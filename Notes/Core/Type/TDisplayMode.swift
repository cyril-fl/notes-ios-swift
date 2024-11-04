enum DisplayMode {
    case list
    case grid
    
    mutating func toggle() {
        self = self == .list ? .grid : .list
    }
}
