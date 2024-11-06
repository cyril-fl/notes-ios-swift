import Foundation
import SwiftUI
import Observation

@Observable
final class useFile: ObservableObject {
    private var _file: File?
    private var _deleteOnCancel: Bool  = false
    private var _isEditing: Bool = false
    private var _display: DisplayMode = .grid

    var current: File? {
        get { _file }
        set { _file = newValue }
    }
    var name: String {
        get {
            current?.name ?? "undefined"
        }
        set {
            current?.name = newValue
        }
    }
    var content: String {
        get {
            current?.content ?? "undefined"
        }
        set {
            current?.content = newValue
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
    var boundDisplay: Binding<DisplayMode> {
        Binding(
            get: { self._display },
            set: { self._display = $0 }
        )
    }
}

