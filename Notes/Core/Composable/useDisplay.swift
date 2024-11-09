import SwiftUI

@Observable
final class useDisplay: ObservableObject {
    private var _display: DisplayMode
    
    init(preset: DisplayMode) {
        self._display = preset
    }
    
    var mode: DisplayMode {
        get {_display}
        set {_display = newValue}
    }
    
    var boundDisplay: Binding<DisplayMode> {
        Binding(
            get: { self._display },
            set: { self._display = $0 }
        )
    }
}


struct DisplayConfig {
    private var preset: DisplayMode
    private var key: UUID
    
    
}

@Observable
final class useDisplayV2: ObservableObject {
    var views: [DisplayConfig] = []
    
    func addConfig(_ config: DisplayConfig) {
        views.append(config)
    }
 
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
}

