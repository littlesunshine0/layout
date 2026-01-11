import Foundation

/// Animation attribute for menus
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum MenuAnimation: String, CaseIterable, Hashable, Codable {
    case fade
    case scale
    case slide
    case none
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var duration: TimeInterval {
        switch self {
        case .fade: return 0.2
        case .scale: return 0.25
        case .slide: return 0.3
        case .none: return 0
        }
    }
}
