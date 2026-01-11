import Foundation

/// Size attribute for controls
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum ControlSize: String, CaseIterable, Hashable, Codable {
    case small
    case medium
    case large
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var height: CGFloat {
        switch self {
        case .small: return 32.0
        case .medium: return 44.0
        case .large: return 56.0
        }
    }
    
    public var padding: CGFloat {
        switch self {
        case .small: return 8.0
        case .medium: return 12.0
        case .large: return 16.0
        }
    }
}
