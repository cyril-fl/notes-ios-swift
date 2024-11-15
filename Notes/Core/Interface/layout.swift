enum Layout: CaseIterable {
    case list
    case grid
    
    mutating func toggle() {
        let i = Self.allCases.firstIndex(of: self)!
        let j = (i + 1) % Self.allCases.count
        self = Self.allCases[j]
    }
}
