import Foundation
import SwiftUI
import Observation

@Observable
final class useFile: ObservableObject {
    private var _file: File?
    private var _deleteOnCancel: Bool  = false
    private var _isEditing: Bool = false
    
    var current: File? {
        get { _file }
        set { _file = newValue }
    }
    
    var id: UUID {
        get { current?.id ?? UUID() }
        set {  }
    }
    
    var name: String {
        get {
            current?.name ?? "undefined"
        }
        set {
            current?.name = useValidate.text(newValue) ?? ""
        }
    }
    var content: String {
        get {
            current?.content ?? "undefined"
        }
        set {
            current?.content = useValidate.text(newValue) ?? "Err"
        }
    }
    var lastModified: Date {
        get { current?.lastUpdateDate ?? Date() }
        set {  }
    }
    
    var delete: Bool {
        get {_deleteOnCancel}
        set {}
    }
    func deleteOnCancel() {
        _deleteOnCancel = true
    }
    func keepOnCancel() {
        _deleteOnCancel = false
    }
    var editing: Bool {
        get {_isEditing}
        set {_isEditing = newValue}
    }

    /* BINDING */
    var boundName: Binding<String> {
        Binding(
            get: { self.name },
            set: { self.name = $0 }
        )
    }
    var boundContent: Binding<String> {
        Binding(
            get: { self.content },
            set: { self.content = $0 }
        )
    }
    var boundSelected: Binding<File?> {
        Binding(
            get: { self._file },
            set: { self._file = $0 }
        )
    }
    var boundPrevent: Binding<Bool> {
        Binding(
            get: { self._deleteOnCancel },
            set: { self._deleteOnCancel = $0 }
        )
    }
    var boundEditing: Binding<Bool> {
        Binding(
            get: {
                withAnimation { self._isEditing }
            },
            set: { self._isEditing = $0 }
        )
    }
}

