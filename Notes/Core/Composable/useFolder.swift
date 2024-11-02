import Foundation
import SwiftUI
import Observation

@Observable
final class useFolder: ObservableObject {
    private var _folder: Folder?
    private var _deleteOnCancel: Bool  = false
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
            current?.name = newValue
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
    var boundPrevent: Binding<Bool> {
        Binding(
            get: { self._deleteOnCancel },
            set: { self._deleteOnCancel = $0 }
        )
    }
    var boundDisplay: Binding<DisplayMode> {
        Binding(
            get: { self._display },
            set: { self._display = $0 }
        )
    }
}
