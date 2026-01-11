import Foundation

/// The visual style and behavior of the window's toolbar
enum ToolbarStyle {
    case automatic
    case expanded
    case preference
    case unified
    case unifiedCompact
    
    static let `default` = ToolbarStyle.automatic
}
