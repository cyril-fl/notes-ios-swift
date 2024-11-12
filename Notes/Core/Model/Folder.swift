import Foundation
import SwiftData

@Model
final class Folder: Identifiable {
    #Unique<Folder>([\.id])
    
    private(set) var id: UUID
    private var _name: String
    
    private var _path: String

    var name: String {
        get { _name }
        set {
            _name = newValue;
        }
    }
    var path: String {
        get { _path }
        set {
            _path = newValue;
            lastUpdateDate = Date();
        }
    }
    private(set) final var creationDate: Date
    var lastUpdateDate: Date
    
    @Relationship(deleteRule: .cascade)
    var files: [File]

    init(name: String, path: String) {
        self.id = UUID()
        self._name = name
        self._path = path
        self.creationDate = Date()
        self.lastUpdateDate = Date()
        self.files = []
    }
    
    func addFile(newFile: File) {
        newFile.path = "/\(self.path)/\(self.name)"
        files.append(newFile)
        lastUpdateDate = Date()
    }
    
    func newFile(name: String, content: String) {
        let path = "/\(self.path)/\(self.name)"
        let temp =  File(name: name, content: content, path: path)
        files.append(temp)
        lastUpdateDate = Date()
    }
    
    func deleteFileById(fileId: UUID) {
        files.removeAll { file in
            file.id == fileId
        }
        lastUpdateDate = Date()
    }
}
