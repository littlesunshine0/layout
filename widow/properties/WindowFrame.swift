import Foundation

/// The position and size of the window, defined by x, y coordinates, width, and height
struct WindowFrame {
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    init(x: CGFloat = 0, y: CGFloat = 0, width: CGFloat = 800, height: CGFloat = 600) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    var rect: CGRect {
        CGRect(x: x, y: y, width: width, height: height)
    }
}
