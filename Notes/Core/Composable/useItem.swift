import SwiftUI

class useItem<T: ContentNode & Identifiable>: Displayable {
    
    var current: T
    /// Indicates whether the `current` folder should be deleted from the context when the user cancels an edit action.
    ///
    /// - `true`:  `current`  will be removed from the context if the edit is canceled.
    /// - `false`:  `current`  will remain unchanged when the edit is canceled.
    ///
    /// Default value is `false`.
    ///
    /// Use this property in edit flows where you want the option to cancel changes without keeping a temporary folder.
    var isDeleteOnCancel: Bool = false
    var editing: Bool = false
    var display: DisplayMode = .list

    init(defaultItem: T, displayMode: DisplayMode = .list) {
        self.current = defaultItem
        self.display = displayMode
    }

    var id: UUID { current.id as! UUID }
    var name: String {
        get { current.name }
        set { current.name = useValidate.text(newValue, length: 120) ?? "" }
    }
    var path: String {
        get { current.path }
        set { current.path = newValue }
    }
    var lastUpdateDate: Date {
        get { current.lastUpdateDate }
        set { current.lastUpdateDate = newValue }
    }
}

@Observable
final class useFolder: useItem<Folder> {
    
    init() {
        let foler = Folder(name: "New File", path: "")
        super.init(defaultItem: foler)
    }
    
    var files: [File] {
        get {
            current.files.sorted(by: { $0.lastUpdateDate > $1.lastUpdateDate })
        }
        set {
            current.files = newValue
        }
    }
}

@Observable
final class useFile: useItem<File> {
    
    init() {
        let file = File(name: "New File", path: "")
        super.init(defaultItem: file)
    }
    
    var content: String {
        get { current.content }
        set { current.content = useValidate.text(newValue) ?? "Err" }
    }
}



//@Observable
//final class useFolder: Displayable {
//    var current: Folder = Folder(name: "Default", path: "undefined")
//    var isDeleteOnCancel: Bool  = false
//    var editing: Bool = false
//    var display: DisplayMode = .list
//
//    var id: UUID {
//        get { current.id }
//        set {  }
//    }
//
//    var name: String {
//        get { current.name }
//        set { current.name = useValidate.text(newValue, length: 120) ?? "" }
//    }
//
//    var path: String {
//        get { current.path }
//        set { current.path = newValue }
//    }
//    var files: [File] {
//        get {
//            //Todo Cree un state qui defini la maniere dans x'est trier
//            current.files.sorted(by: { _f1, _f2 in
//                _f1.lastUpdateDate > _f2.lastUpdateDate
//            })
//        }
//        set {
//            current.files = newValue
//        }
//    }
//
//    var lastUpdateDate: Date {
//        get { current.lastUpdateDate }
//        set { current.lastUpdateDate = newValue }
//    }
//}


//@Observable
//final class useFile: Displayable {
//    var current: File = File(name: "Default", content: "undefined", path: "undefined")
//    var editing: Bool = false
//    var display: DisplayMode = .grid
//
//    var id: UUID {
//        get { current.id }
//        set {  }
//    }
//    var name: String {
//        get { current.name }
//        set { current.name = useValidate.text(newValue, length: 120) ?? "" }
//    }
//    var content: String {
//        get { current.content }
//        set { current.content = useValidate.text(newValue) ?? "Err" }
//    }
//    var lastUpdateDate: Date {
//        get { current.lastUpdateDate }
//        set { current.lastUpdateDate = newValue }
//    }
//}
//
//
