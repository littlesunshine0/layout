import Foundation

/// Elevation attribute for cards
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum CardElevation: Int, CaseIterable, Hashable, Codable {
    case flat = 0
    case low = 1
    case medium = 2
    case high = 3
    
    public var shadowRadius: CGFloat {
        switch self {
        case .flat: return 0
        case .low: return 2.0
        case .medium: return 4.0
        case .high: return 8.0
        }
    }
    
    public var shadowOpacity: Float {
        switch self {
        case .flat: return 0
        case .low: return 0.1
        case .medium: return 0.15
        case .high: return 0.2
        }
    }
}
