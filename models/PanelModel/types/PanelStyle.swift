import Foundation

/// Style type for panels
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum PanelStyle: String, CaseIterable, Hashable, Codable {
    case standard
    case floating
    case compact
    case transparent
    case blurred
    case card
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultBorderRadius: CGFloat {
        switch self {
        case .standard: return 0
        case .floating: return 12.0
        case .compact: return 4.0
        case .transparent: return 0
        case .blurred: return 8.0
        case .card: return 16.0
        }
    }
}
