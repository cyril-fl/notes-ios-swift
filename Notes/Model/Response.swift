import Foundation

struct Response {
    var insert: Int
    var update: Int
    var delete: Int
    var error: String?
    
    init(insert: Int, update: Int, delete: Int, error: String? = nil) {
        self.insert = insert
        self.update = update
        self.delete = delete
        self.error = error
    }
}
