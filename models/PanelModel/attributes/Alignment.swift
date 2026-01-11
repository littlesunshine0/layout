import Foundation

/// Alignment attribute for panels
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum PanelAlignment: String, CaseIterable, Hashable, Codable {
    case leading
    case trailing
    case center
    case top
    case bottom
    
    public var description: String {
        rawValue.capitalized
    }
}
