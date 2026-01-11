import Foundation

/// An integer that determines the window's stacking order relative to other windows
struct WindowLevel {
    var value: Int
    
    init(_ level: Int = 0) {
        self.value = level
    }
    
    static let normal = WindowLevel(0)
    static let floating = WindowLevel(3)
    static let tornOffMenu = WindowLevel(5)
    static let modalPanel = WindowLevel(8)
    static let mainMenu = WindowLevel(24)
    static let status = WindowLevel(25)
    static let popUpMenu = WindowLevel(101)
    static let screenSaver = WindowLevel(1000)
}
