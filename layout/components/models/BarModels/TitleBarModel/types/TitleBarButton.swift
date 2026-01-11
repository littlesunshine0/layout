import Foundation

/// Title bar button type definition
/// Defines button types and configurations for title bar
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarButton {
    case close
    case minimize
    case maximize
    case fullscreen
    case custom(icon: String, action: () -> Void)
    
    public var icon: String {
        switch self {
        case .close: return "xmark"
        case .minimize: return "minus"
        case .maximize: return "plus"
        case .fullscreen: return "arrow.up.left.and.arrow.down.right"
        case .custom(let icon, _): return icon
        }
    }
    
    public var accessibilityLabel: String {
        switch self {
        case .close: return "Close"
        case .minimize: return "Minimize"
        case .maximize: return "Maximize"
        case .fullscreen: return "Toggle Fullscreen"
        case .custom: return "Custom Button"
        }
    }
}

/// Title bar button configuration
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarButtonConfig {
    public var type: TitleBarButton
    public var isEnabled: Bool
    public var isVisible: Bool
    public var position: ButtonPosition
    
    public enum ButtonPosition {
        case leading
        case trailing
        case custom(index: Int)
    }
    
    public init(type: TitleBarButton, isEnabled: Bool = true, isVisible: Bool = true, position: ButtonPosition = .trailing) {
        self.type = type
        self.isEnabled = isEnabled
        self.isVisible = isVisible
        self.position = position
    }
}

/// Title bar button style
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarButtonStyle {
    case standard
    case minimal
    case colorful
    case custom(foreground: String, background: String)
}
