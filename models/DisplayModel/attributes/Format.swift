import Foundation

/// Format attribute for displays
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum DisplayFormat: String, CaseIterable, Hashable, Codable {
    case numeric
    case percentage
    case currency
    case date
    case time
    case text
    
    public var description: String {
        rawValue.capitalized
    }
}
