import Foundation
import SwiftData


// TODO Supprimer Searchable
@Model
class File: Identifiable, ContentNode {
    #Unique<File>([\.id])

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
