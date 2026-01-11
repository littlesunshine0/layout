import Foundation

/// Variant attribute for controls
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum ControlVariant: String, CaseIterable, Hashable, Codable {
    case primary
    case secondary
    case tertiary
    case destructive
    case ghost
    case link
    
    public var description: String {
        rawValue.capitalized
    }
}
