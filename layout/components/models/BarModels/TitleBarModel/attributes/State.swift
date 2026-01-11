import Foundation

/// Title bar state attribute
/// Tracks the current state of the title bar component
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarState {
    case active
    case inactive
    case disabled
    case hidden
    case collapsed
    case expanded
    
    public var isInteractive: Bool {
        switch self {
        case .active, .inactive: return true
        case .disabled, .hidden: return false
        case .collapsed, .expanded: return true
        }
    }
    
    public var description: String {
        switch self {
        case .active: return "Active"
        case .inactive: return "Inactive"
        case .disabled: return "Disabled"
        case .hidden: return "Hidden"
        case .collapsed: return "Collapsed"
        case .expanded: return "Expanded"
        }
    }
}

/// Title bar interactive state
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarInteractiveState {
    public var isEnabled: Bool
    public var isVisible: Bool
    public var isHovered: Bool
    public var isFocused: Bool
    
    public init(isEnabled: Bool = true, isVisible: Bool = true, isHovered: Bool = false, isFocused: Bool = false) {
        self.isEnabled = isEnabled
        self.isVisible = isVisible
        self.isHovered = isHovered
        self.isFocused = isFocused
    }
}
