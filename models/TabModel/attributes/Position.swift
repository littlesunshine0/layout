import Foundation

/// Position attribute for tabs
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum TabPosition: String, CaseIterable, Hashable, Codable {
    case top
    case bottom
    case leading
    case trailing
    
    public var description: String {
        rawValue.capitalized
    }
}
