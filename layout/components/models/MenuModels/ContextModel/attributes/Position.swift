import Foundation

/// Context menu position attribute
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct ContextMenuPosition {
    public var x: CGFloat
    public var y: CGFloat
    public var anchor: Anchor
    
    public enum Anchor {
        case cursor
        case element
        case custom
    }
    
    public init(x: CGFloat = 0, y: CGFloat = 0, anchor: Anchor = .cursor) {
        self.x = x
        self.y = y
        self.anchor = anchor
    }
}
