import Foundation

/// Style type for displays
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum DisplayStyle: String, CaseIterable, Hashable, Codable {
    case minimal
    case standard
    case detailed
    case compact
    
    public var description: String {
        rawValue.capitalized
    }
}
