//import SwiftUI
//
//@Observable
//final class useDisplay: ObservableObject {
//    private var _display: DisplayMode
//    
//    init(preset: DisplayMode) {
//        self._display = preset
//    }
//    
//    var mode: DisplayMode {
//        get {_display}
//        set {_display = newValue}
//    }
//    
//    var boundDisplay: Binding<DisplayMode> {
//        Binding(
//            get: { self._display },
//            set: { self._display = $0 }
//        )
//    }
//}
//
//
//struct DisplayConfig: Equatable {
//    private var mode: DisplayMode
//    private var key: UUID
//    
//    // Ajout des propriétés pour rendre DisplayConfig comparable
//    static func ==(lhs: DisplayConfig, rhs: DisplayConfig) -> Bool {
//        return lhs.key == rhs.key && lhs.mode == rhs.mode
//    }
//    
//    init(mode: DisplayMode, key: UUID) {
//        self.mode = mode
//        self.key = key
//    }
//    
//    // Propriétés comme avant
//    var preset: DisplayMode {
//        get { mode }
//        set { mode = newValue }
//    }
//}
//
//@Observable
//final class useDisplayV2: ObservableObject {
//    var views: [DisplayConfig] = []
//    
//    func addConfig(_ config: DisplayConfig) {
//        // Vérifier si la configuration existe déjà dans le tableau
//        if !views.contains(where: { $0 == config }) {
//            views.append(config)
//        }
//    }
// 
////    var mode: DisplayMode {
////        get {_display}
////        set {_display = newValue}
////    }
////    
////    var boundDisplay: Binding<DisplayMode> {
////        Binding(
////            get: { self._display },
////            set: { self._display = $0 }
////        )
////    }
//}
//
