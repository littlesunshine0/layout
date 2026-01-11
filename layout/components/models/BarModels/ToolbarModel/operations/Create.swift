import Foundation

/// Toolbar create operation
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct ToolbarCreateOperation {
    public static func create(style: ToolbarStyle = .default) -> ToolbarInstance {
        return ToolbarInstance(style: style)
    }
}

public enum ToolbarStyle {
    case `default`
    case compact
    case unified
}

public class ToolbarInstance {
    public let id: UUID
    public var style: ToolbarStyle
    
    public init(style: ToolbarStyle) {
        self.id = UUID()
        self.style = style
    }
}
