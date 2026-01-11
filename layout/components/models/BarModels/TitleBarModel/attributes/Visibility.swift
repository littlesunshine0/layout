import Foundation

/// Title bar visibility attribute
/// Controls the visibility and display behavior of the title bar
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarVisibility {
    case visible
    case hidden
    case autoHide
    case conditional(predicate: () -> Bool)
    
    public var isVisible: Bool {
        switch self {
        case .visible: return true
        case .hidden: return false
        case .autoHide: return true
        case .conditional(let predicate): return predicate()
        }
    }
}

/// Title bar opacity configuration
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarOpacity {
    public var value: CGFloat
    
    public init(_ value: CGFloat) {
        self.value = min(max(value, 0.0), 1.0)
    }
    
    public static let opaque = TitleBarOpacity(1.0)
    public static let transparent = TitleBarOpacity(0.0)
    public static let translucent = TitleBarOpacity(0.8)
}
