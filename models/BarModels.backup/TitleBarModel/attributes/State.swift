import Foundation

/// State attribute for TitleBar component
/// Defines the current state of the title bar
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum TitleBarState: String, Codable, CaseIterable {
    case normal
    case focused
    case inactive
    case disabled
    case fullscreen
    
    public var description: String {
        switch self {
        case .normal: return "Normal"
        case .focused: return "Focused"
        case .inactive: return "Inactive"
        case .disabled: return "Disabled"
        case .fullscreen: return "Fullscreen"
        }
    }
}
