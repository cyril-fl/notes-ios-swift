import SwiftUI
import SwiftData

protocol UUIDentifiable: Identifiable {
    var id: UUID { get }
}

@Observable
class usePath<T: ContentNode & UUIDentifiable> {
    var item: [T] = [] // Use @Published for reactivity in SwiftUI

    // Converts an array of UUIDs into a raw string path.
    ///
    /// - Parameter path: An array of UUIDs representing the path of folders.
    /// - Returns: A string representing the concatenated UUIDs, separated by slashes (`/`).
    ///            If the input array is empty, it returns `"undefined path"`.
    func rawValue(_ path: [UUID]) -> String {
        let pathString = path.map(\.uuidString).joined(separator: "/")
        return pathString.isEmpty ? "undefined path" : "/\(pathString)"
    }

    /// Formats a path of UUIDs into a string representation using folder names.
    ///
    /// - Parameter path: An array of UUIDs representing the path.
    /// - Returns: A formatted string path with folder names, or `"undefined path"` if no folder names are found.    
    func formatted(_ path: [UUID]) -> String {
        let namePath = path.compactMap { id in
            item.first(where: { $0.id == id })?.name
        }

        return namePath.isEmpty ? "undefined path" : "/" + namePath.joined(separator: "/")
    }
}
