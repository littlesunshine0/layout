import Foundation

/// Position attribute for menus
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct MenuPosition: Hashable, Codable {
    public var x: CGFloat
    public var y: CGFloat
    public var anchor: Anchor
    
    public enum Anchor: String, CaseIterable, Hashable, Codable {
        case topLeading
        case top
        case topTrailing
        case leading
        case center
        case trailing
        case bottomLeading
        case bottom
        case bottomTrailing
    }
    
    public init(x: CGFloat = 0, y: CGFloat = 0, anchor: Anchor = .topLeading) {
        self.x = x
        self.y = y
        self.anchor = anchor
    }
    
    public static let topLeft = MenuPosition(x: 0, y: 0, anchor: .topLeading)
    public static let topRight = MenuPosition(x: 0, y: 0, anchor: .topTrailing)
    public static let bottomLeft = MenuPosition(x: 0, y: 0, anchor: .bottomLeading)
    public static let bottomRight = MenuPosition(x: 0, y: 0, anchor: .bottomTrailing)
}
