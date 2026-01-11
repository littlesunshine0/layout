import Foundation

/// Constrains the window's width and height to a specific ratio when the user resizes it
struct WindowAspectRatio {
    var width: CGFloat
    var height: CGFloat
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    var ratio: CGFloat {
        width / height
    }
    
    static let square = WindowAspectRatio(width: 1, height: 1)
    static let widescreen = WindowAspectRatio(width: 16, height: 9)
    static let standard = WindowAspectRatio(width: 4, height: 3)
}
