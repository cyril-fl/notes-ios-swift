import SwiftUI

 struct DefaultFolderNameKey: EnvironmentKey {
    static var defaultValue: String = "Nouveau dossier"  // Valeur par défaut
}
private struct DefaultFileNameKey: EnvironmentKey {
    static var defaultValue: String = "Nouvelle note"  // Valeur par défaut
}

extension EnvironmentValues {
    var defaultFolderName: String {
        get { self[DefaultFolderNameKey.self] }
        set { self[DefaultFolderNameKey.self] = newValue }
    }
    var defaultFileName: String {
        get { self[DefaultFileNameKey.self] }
        set { self[DefaultFileNameKey.self] = newValue }
    }
}




