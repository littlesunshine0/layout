import Foundation

/// A boolean indicating if the window is currently in full-screen mode
struct WindowIsFullScreen {
    var value: Bool
    
    init(_ isFullScreen: Bool = false) {
        self.value = isFullScreen
    }
}
