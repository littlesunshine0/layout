import Foundation

/// Style type for menus
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum MenuStyle: String, CaseIterable, Hashable, Codable {
    case standard
    case compact
    case large
    case minimal
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var itemHeight: CGFloat {
        switch self {
        case .standard: return 36.0
        case .compact: return 28.0
        case .large: return 48.0
        case .minimal: return 32.0
        }
    }
}
