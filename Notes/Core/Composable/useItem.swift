import SwiftUI

@Observable
class useItem<T: Identifiable & ContentNode>: Editable {
    var current: T?
    var isDeleteOnCancel: Bool = false
    var editing: Bool = false
    var display: Layout
    
    init(display: Layout) {
        self.display = display
    }
    
    var id: UUID { current?.id as! UUID }

    var name: String {
        get { current?.name ?? "undefined" }
        set {
            current?.name =
            useValidate.text(newValue, length: 120) ?? ""
        }
    }
    
    var path: String {
        get { current?.path ?? "undefined" }
        set { current?.path = newValue }
    }
    
    var lastUpdateDate: Date {
        get { current?.lastUpdateDate ?? Date() }
        set { current?.lastUpdateDate = newValue }
    }
}

@Observable
final class useFolder: useItem<Folder> {
    init() {
        super.init(display: .list)
    }
    
    var files: [File] {
        get {
            current?.files
                .sorted(by: { $0.lastUpdateDate > $1.lastUpdateDate }) ?? []
        }
        set {
            current?.files = newValue
        }
    }
}

@Observable
final class useFile: useItem<File> {
    init() {
        super.init(display: .list)
    }
    
    var content: String {
        get { current?.content ?? "undefined" }
        set { current?.content = useValidate.text(newValue) ?? "Err" }
    }
}
