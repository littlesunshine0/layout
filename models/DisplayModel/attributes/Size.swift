import Foundation

/// Size attribute for displays
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum DisplaySize: String, CaseIterable, Hashable, Codable {
    case small
    case medium
    case large
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var dimension: CGFloat {
        switch self {
        case .small: return 16.0
        case .medium: return 24.0
        case .large: return 32.0
        }
    }
}
