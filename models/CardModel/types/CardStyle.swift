import Foundation

/// Style type for cards
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum CardStyle: String, CaseIterable, Hashable, Codable {
    case standard
    case outlined
    case filled
    case elevated
    case flat
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultElevation: CardElevation {
        switch self {
        case .standard: return .medium
        case .outlined: return .flat
        case .filled: return .low
        case .elevated: return .high
        case .flat: return .flat
        }
    }
}
