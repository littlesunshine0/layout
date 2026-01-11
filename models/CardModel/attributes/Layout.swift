import Foundation

/// Layout attribute for cards
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum CardLayout: String, CaseIterable, Hashable, Codable {
    case vertical
    case horizontal
    case grid
    
    public var description: String {
        rawValue.capitalized
    }
}
