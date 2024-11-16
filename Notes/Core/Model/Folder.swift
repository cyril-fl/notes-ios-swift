import Foundation
import SwiftData

@Model
final class Folder: ContentNode, UUIDentifiable {
    #Unique<Folder>([\.id])
    
    private(set) var id: UUID
    private var _name: String
    private var _path: [UUID]

    var name: String {
        get { _name }
        set {
            _name = newValue;
        }
    }
    var path: [UUID] {
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

    init(name: String, path: [UUID] = []) {
        self.id = UUID()
        self._name = name
        self._path = path
        self.creationDate = Date()
        self.lastUpdateDate = Date()
        self.files = []
    }
  
    func addFile(_ newFile: File) {
        let path = self.path + [self.id]
        newFile.path = path
        files.append(newFile)
    }
    
    func newFile(name: String = "", content: String = "") {
        let path = self.path + [self.id]
        let temp = File(name: name, content: content, path: path)
        files.append(temp)
    }
    
    func deleteFileById(fileId: UUID) {
        files.removeAll { file in
            file.id == fileId
        }
    }
}
