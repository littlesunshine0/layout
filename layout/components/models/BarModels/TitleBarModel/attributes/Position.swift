import Foundation

/// Title bar position attribute
/// Defines the position and placement of the title bar
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarPosition {
    public var x: CGFloat
    public var y: CGFloat
    public var zIndex: Int
    
    public init(x: CGFloat = 0, y: CGFloat = 0, zIndex: Int = 100) {
        self.x = x
        self.y = y
        self.zIndex = zIndex
    }
    
    /// Predefined positions
    public static let top = TitleBarPosition(x: 0, y: 0, zIndex: 100)
    public static let bottom = TitleBarPosition(x: 0, y: -44, zIndex: 100)
    public static let floating = TitleBarPosition(x: 0, y: 0, zIndex: 200)
}

/// Title bar anchor point for positioning
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarAnchor {
    case topLeading
    case topCenter
    case topTrailing
    case custom(x: CGFloat, y: CGFloat)
    
    public var point: (x: CGFloat, y: CGFloat) {
        switch self {
        case .topLeading: return (0, 0)
        case .topCenter: return (0.5, 0)
        case .topTrailing: return (1, 0)
        case .custom(let x, let y): return (x, y)
        }
    }
}
