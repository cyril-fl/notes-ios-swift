import SwiftUI

@Observable
class useSearch: ObservableObject {
    var query: String = ""
    var results: [Any] = []
    var _isPresented: Bool = false
    
    var boundQuery: Binding<String> {
        return .init(get: { self.query }, set: { self.query = $0 })
    }
    
    var boudResults: Binding<[Any]> {
        return .init(get: { self.results }, set: { self.results = $0 })
    }
    
    func filterResults<T>(from items: [T], usingKey keyPath: KeyPath<T, String>) {
        guard !query.isEmpty else {
            results = []
            return
        }
        
        let _i = items.filter { item in
            let value = item[keyPath: keyPath]
            return value.contains(query)  // Filtrage selon la query
        }
    
        results = _i as [Any]
    }
    
    var boundIsPresented: Binding<Bool> {
        return .init(get: { self._isPresented }, set: { self._isPresented = $0 })
    }
    
}
