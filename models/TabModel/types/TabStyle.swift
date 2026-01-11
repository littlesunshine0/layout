import Foundation

/// Style type for tabs
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum TabStyle: String, CaseIterable, Hashable, Codable {
    case standard
    case pills
    case segmented
    case minimal
    case outlined
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultBorderRadius: CGFloat {
        switch self {
        case .standard: return 0
        case .pills: return 16.0
        case .segmented: return 8.0
        case .minimal: return 0
        case .outlined: return 4.0
        }
    }
}
