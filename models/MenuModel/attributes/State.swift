import Foundation

/// State attribute for menus
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum MenuState: String, CaseIterable, Hashable, Codable {
    case closed
    case opening
    case open
    case closing
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var isVisible: Bool {
        self == .open || self == .opening
    }
}
