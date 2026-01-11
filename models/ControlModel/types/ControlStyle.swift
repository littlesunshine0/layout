import Foundation

/// Style type for controls
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum ControlStyle: String, CaseIterable, Hashable, Codable {
    case filled
    case outlined
    case text
    case elevated
    case flat
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultBorderWidth: CGFloat {
        switch self {
        case .outlined: return 1.0
        case .filled, .text, .elevated, .flat: return 0
        }
    }
}
