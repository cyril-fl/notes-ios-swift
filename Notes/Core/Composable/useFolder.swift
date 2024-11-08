import Foundation
import SwiftUI
import Observation

@Observable
final class useFolder: ObservableObject {
    private var _folder: Folder?
    private var _deleteOnCancel: Bool  = false
    private var _isEditing: Bool = false
    private var _display: DisplayMode = .list

    var current: Folder? {
        get { _folder }
        set { _folder = newValue }
    }
    var name: String {
        get {
            current?.name ?? "undefined"
        }
        set {
            current?.name = useValidate.text(newValue) ?? "Err"
        }
    }
    var path: String {
        get {
            current?.path ?? "undefined"
        }
        set {
            current?.path = newValue
        }
    }
    var files: [File] {
        get {
            //Todo Cree un state qui defini la maniere dans x'est trier
            current?.files.sorted(by: { _f1, _f2 in
                _f1.lastUpdateDate > _f2.lastUpdateDate
            }) ?? []
        }
        set {
            current?.files = newValue
        }
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
    var display: DisplayMode {
        get {_display}
        set {_display = newValue}
    }
    

    /* BINDING */
    var boundSelected: Binding<Folder?> {
        Binding(
            get: { self._folder },
            set: { self._folder = $0 }
        )
    }
    var boundFiles: Binding<[File]> {
        Binding(
            get: { self._folder?.files ?? [] },
            set: { self._folder?.files = $0 }
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
            get: { self._isEditing },
            set: { self._isEditing = $0 }
        )
    }
    var boundDisplay: Binding<DisplayMode> {
        Binding(
            get: { self._display },
            set: { self._display = $0 }
        )
    }
}
