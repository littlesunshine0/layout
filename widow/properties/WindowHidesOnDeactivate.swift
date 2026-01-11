import Foundation

/// A boolean indicating if the window is hidden when its application becomes inactive
struct WindowHidesOnDeactivate {
    var value: Bool
    
    init(_ hidesOnDeactivate: Bool = false) {
        self.value = hidesOnDeactivate
    }
}
