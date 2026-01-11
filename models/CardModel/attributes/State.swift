import Foundation

/// State attribute for cards
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum CardState: String, CaseIterable, Hashable, Codable {
    case normal
    case hovered
    case selected
    case pressed
    case disabled
    case focused
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var isInteractive: Bool {
        self != .disabled
    }
}
