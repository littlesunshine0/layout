import Foundation

/// Color scheme attribute for displays
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum DisplayColorScheme: String, CaseIterable, Hashable, Codable {
    case primary
    case secondary
    case success
    case warning
    case error
    case info
    case neutral
    
    public var description: String {
        rawValue.capitalized
    }
}
