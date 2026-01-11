import Foundation

/// A boolean indicating whether the window is currently visible on the screen
struct WindowIsVisible {
    var value: Bool
    
    init(_ isVisible: Bool = true) {
        self.value = isVisible
    }
}
