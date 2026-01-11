import Foundation

/// The background color of the window
struct WindowBackgroundColor {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    init(red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    static var white: WindowBackgroundColor {
        WindowBackgroundColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    static var black: WindowBackgroundColor {
        WindowBackgroundColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
}
