import Foundation

/// Toolbar item type definition
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum ToolbarItemType {
    case button
    case toggle
    case menu
    case separator
    case spacer
    case custom
}
