import Foundation

/// A boolean indicating whether the window includes a toolbar
struct WindowHasToolbar {
    var value: Bool
    
    init(_ hasToolbar: Bool = false) {
        self.value = hasToolbar
    }
}
