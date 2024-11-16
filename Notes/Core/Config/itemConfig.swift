import SwiftUI

/// `DefaultFolderNameKey` is an environment key used to provide a default folder name.
/// - `defaultValue`: The default value is `"Nouveau dossier"`.
private struct DefaultFolderNameKey: EnvironmentKey {
    static var defaultValue: String = "Nouveau dossier"
}

/// `DefaultFileNameKey` is an environment key used to provide a default file name.
/// - `defaultValue`: The default value is `"Nouvelle note"`.
private struct DefaultFileNameKey: EnvironmentKey {
    static var defaultValue: String = "Nouvelle note"
}

/// `DefaultNameKey` is a generic environment key used to provide a default name when neither a folder nor a file is specified.
/// - `defaultValue`: The default value is an empty string `""`.
private struct DefaultNameKey: EnvironmentKey {
    static var defaultValue: String = ""
}

/// `DefaultItemKey` is an environment key used to provide a default item that conforms to the `Editable` protocol.
/// - `defaultValue`: The default value is `nil`, indicating that no default item is specified.
private struct DefaultItemKey: EnvironmentKey {
    static var defaultValue: (any Editable)? = nil
}

/// `DefaultFolderLayoutKey` is an environment key used to provide a default layout.
/// - `defaultValue`: The default value is `".list"`.
private struct DefaultFolderLayoutKey: EnvironmentKey {
    static var defaultValue: Layout = .list
}

/// `DefaultFileLayoutKey` is an environment key used to provide a default layout.
/// - `defaultValue`: The default value is `".grid"`.
private struct DefaultFileLayoutKey: EnvironmentKey {
    static var defaultValue: Layout = .grid
}

extension EnvironmentValues {
    /// The default folder name, derived from `DefaultFolderNameKey`.
    /// - Default: `"Nouveau dossier"`.
    var defaultFolderName: String {
        get { self[DefaultFolderNameKey.self] }
        set { self[DefaultFolderNameKey.self] = newValue }
    }

    /// The default file name, derived from `DefaultFileNameKey`.
    /// - Default: `"Nouvelle note"`.
    var defaultFileName: String {
        get { self[DefaultFileNameKey.self] }
        set { self[DefaultFileNameKey.self] = newValue }
    }

    /// The generic default name, derived from `DefaultNameKey`.
    /// - Default: `""` (empty string).
    var defaultName: String {
        get { self[DefaultNameKey.self] }
        set { self[DefaultNameKey.self] = newValue }
    }

    /// The default item that conforms to `Editable`, derived from `DefaultItemKey`.
    /// - Default: `nil`, indicating no default item is specified.
    var defaultItemKey: (any Editable)? {
        get { self[DefaultItemKey.self] }
        set { self[DefaultItemKey.self] = newValue }
    }
    
    
    
    
    /// The default layout, derived from `DefaultFolderLayoutKey`.
    /// - Default: `".list"`.
    var defaultFolderLayout: Layout {
        get { self[DefaultFolderLayoutKey.self] }
        set { self[DefaultFolderLayoutKey.self] = newValue }
    }
    /// The default layout, derived from `DefaultFileLayoutKey`.
    /// - Default: `".grid".
    var defaultFileLayout: Layout {
        get { self[DefaultFileLayoutKey.self] }
        set { self[DefaultFileLayoutKey.self] = newValue }
    }
    
}
