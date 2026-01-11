import Foundation

/// Badge create operation
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct BadgeCreateOperation {
    public static func create(value: String, style: BadgeStyle = .default) -> BadgeInstance {
        return BadgeInstance(value: value, style: style)
    }
}

public enum BadgeStyle {
    case `default`
    case success
    case warning
    case error
    case info
}

public struct BadgeInstance {
    public let id: UUID
    public var value: String
    public var style: BadgeStyle
    
    public init(value: String, style: BadgeStyle) {
        self.id = UUID()
        self.value = value
        self.style = style
    }
}
