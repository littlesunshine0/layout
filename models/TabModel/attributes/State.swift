import Foundation

/// State attribute for tabs
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum TabState: String, CaseIterable, Hashable, Codable {
    case normal
    case selected
    case hovered
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
