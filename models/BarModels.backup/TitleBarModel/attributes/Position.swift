import Foundation

/// Position attribute for TitleBar component
/// Defines the position of the title bar in the window
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum TitleBarPosition: String, Codable, CaseIterable {
    case top
    case bottom
    case floating
    
    public var description: String {
        switch self {
        case .top: return "Top"
        case .bottom: return "Bottom"
        case .floating: return "Floating"
        }
    }
}
