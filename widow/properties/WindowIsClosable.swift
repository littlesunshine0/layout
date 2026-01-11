import Foundation

/// A boolean indicating if the window has a close button and can be closed by the user
struct WindowIsClosable {
    var value: Bool
    
    init(_ isClosable: Bool = true) {
        self.value = isClosable
    }
}
