import Foundation

/// Position attribute for panels
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct PanelPosition: Hashable, Codable {
    public var x: CGFloat
    public var y: CGFloat
    public var isFixed: Bool
    
    public init(x: CGFloat = 0, y: CGFloat = 0, isFixed: Bool = false) {
        self.x = x
        self.y = y
        self.isFixed = isFixed
    }
    
    public static let leadingTop = PanelPosition(x: 0, y: 0, isFixed: true)
    public static let trailingTop = PanelPosition(x: CGFloat.infinity, y: 0, isFixed: true)
    public static let center = PanelPosition(x: 0.5, y: 0.5, isFixed: false)
}
