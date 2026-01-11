import Foundation

/// Style type for bars
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum BarStyle: String, CaseIterable, Hashable, Codable {
    case standard
    case unified
    case compact
    case large
    case transparent
    case blurred
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultHeight: CGFloat {
        switch self {
        case .standard: return 44.0
        case .unified: return 52.0
        case .compact: return 32.0
        case .large: return 96.0
        case .transparent: return 44.0
        case .blurred: return 44.0
        }
    }
}
