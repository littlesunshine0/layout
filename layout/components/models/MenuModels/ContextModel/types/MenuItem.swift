import Foundation

/// Context menu item type
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum ContextMenuItemType {
    case action
    case submenu
    case separator
    case header
}
