import Foundation

/// Similar to aspectRatio, but specifically relates to the view content area rather than the entire window frame
struct WindowContentAspectRatio {
    var width: CGFloat
    var height: CGFloat
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    var ratio: CGFloat {
        width / height
    }
    
    static let square = WindowContentAspectRatio(width: 1, height: 1)
    static let widescreen = WindowContentAspectRatio(width: 16, height: 9)
    static let standard = WindowContentAspectRatio(width: 4, height: 3)
}
