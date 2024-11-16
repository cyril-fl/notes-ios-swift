import Foundation
import SwiftData

@Model
class File: ContentNode, UUIDentifiable {
    #Unique<File>([\.id])

    private(set) final var id: UUID
    var name: String
    // TODO: Changer par description
    var content: String
    var path: [UUID]
    private(set) final var creationDate: Date
    var lastUpdateDate: Date

    
    init(name: String = "", content: String = "", path: [UUID] = [] ) {
        self.id = UUID()
        self.name = name
        self.content = content
        self.path = path
        self.creationDate = Date()
        self.lastUpdateDate = Date()
    }
}
