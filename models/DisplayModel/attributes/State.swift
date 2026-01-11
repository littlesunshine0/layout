import Foundation

/// State attribute for displays
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum DisplayState: String, CaseIterable, Hashable, Codable {
    case normal
    case loading
    case error
    case empty
    case updating
    
    public var description: String {
        rawValue.capitalized
    }
}
