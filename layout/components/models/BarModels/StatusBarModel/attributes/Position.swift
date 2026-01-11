import Foundation

/// Status bar position attribute
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct StatusBarPosition {
    public var dock: Dock
    public var offset: CGFloat
    
    public enum Dock {
        case top
        case bottom
        case floating
    }
    
    public init(dock: Dock = .bottom, offset: CGFloat = 0) {
        self.dock = dock
        self.offset = offset
    }
}
