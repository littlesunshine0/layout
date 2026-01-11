import Foundation

/// TitleBarButton type definition
/// Defines the types of buttons available in the title bar
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum TitleBarButton: String, Codable, CaseIterable {
    case close
    case minimize
    case maximize
    case settings
    case help
    case fullscreen
    case custom
    
    public var icon: String {
        switch self {
        case .close: return "xmark"
        case .minimize: return "minus"
        case .maximize: return "arrow.up.left.and.arrow.down.right"
        case .settings: return "gearshape"
        case .help: return "questionmark.circle"
        case .fullscreen: return "arrow.up.left.and.arrow.down.right.square"
        case .custom: return "circle"
        }
    }
    
    public var description: String {
        switch self {
        case .close: return "Close"
        case .minimize: return "Minimize"
        case .maximize: return "Maximize"
        case .settings: return "Settings"
        case .help: return "Help"
        case .fullscreen: return "Fullscreen"
        case .custom: return "Custom"
        }
    }
}
