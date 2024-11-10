import Foundation
import SwiftData

@Model
class File: Identifiable, Searchable {
    #Unique<File>([\.id])

    // TODO la relation inverse ne se fait pas
    private(set) final var id: UUID
    var name: String {
        didSet { lastUpdateDate = Date() }
    }
    var content: String {
        didSet { lastUpdateDate = Date() }
    }
    var path: String {
        didSet { lastUpdateDate = Date() }
    }
    private(set) final var creationDate: Date
    var lastUpdateDate: Date

    
    init(name: String = "", content: String = "", path: String) {
        self.id = UUID()
        self.name = name
        self.content = content
        self.path = path
        self.creationDate = Date()
        self.lastUpdateDate = Date()
    }
}
