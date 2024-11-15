import Foundation
import SwiftData

@Model
class File: Identifiable, ContentNode {
    #Unique<File>([\.id])

    private(set) final var id: UUID
    var name: String
    // TODO: Changer par description
    var content: String
    var path: String 
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
