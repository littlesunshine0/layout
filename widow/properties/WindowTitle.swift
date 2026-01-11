import Foundation

/// The text displayed in the window's title bar
struct WindowTitle {
    var value: String
    
    init(_ title: String = "Untitled") {
        self.value = title
    }
}
