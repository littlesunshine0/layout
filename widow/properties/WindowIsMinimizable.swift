import Foundation

/// A boolean indicating if the window can be minimized to the Dock
struct WindowIsMinimizable {
    var value: Bool
    
    init(_ isMinimizable: Bool = true) {
        self.value = isMinimizable
    }
}
