import Foundation

/// Title bar position type definition
/// Defines positioning structures and calculations
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarPositionType {
    public var origin: Point
    public var anchor: AnchorPoint
    public var offset: Offset
    
    public struct Point {
        public var x: CGFloat
        public var y: CGFloat
        
        public init(x: CGFloat = 0, y: CGFloat = 0) {
            self.x = x
            self.y = y
        }
    }
    
    public struct AnchorPoint {
        public var horizontal: CGFloat
        public var vertical: CGFloat
        
        public init(horizontal: CGFloat = 0.5, vertical: CGFloat = 0.0) {
            self.horizontal = horizontal
            self.vertical = vertical
        }
        
        public static let topLeading = AnchorPoint(horizontal: 0.0, vertical: 0.0)
        public static let topCenter = AnchorPoint(horizontal: 0.5, vertical: 0.0)
        public static let topTrailing = AnchorPoint(horizontal: 1.0, vertical: 0.0)
    }
    
    public struct Offset {
        public var dx: CGFloat
        public var dy: CGFloat
        
        public init(dx: CGFloat = 0, dy: CGFloat = 0) {
            self.dx = dx
            self.dy = dy
        }
        
        public static let zero = Offset(dx: 0, dy: 0)
    }
    
    public init(origin: Point = Point(), anchor: AnchorPoint = .topCenter, offset: Offset = .zero) {
        self.origin = origin
        self.anchor = anchor
        self.offset = offset
    }
    
    /// Calculates final position with anchor and offset
    public func calculate(in bounds: CGRect) -> Point {
        let anchorX = bounds.width * anchor.horizontal
        let anchorY = bounds.height * anchor.vertical
        
        return Point(
            x: origin.x + anchorX + offset.dx,
            y: origin.y + anchorY + offset.dy
        )
    }
}
