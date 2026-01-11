import Foundation

/// A boolean indicating if the user can resize the window manually
struct WindowIsResizable {
    var value: Bool
    
    init(_ isResizable: Bool = true) {
        self.value = isResizable
    }
}
