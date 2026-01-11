import Foundation

/// Alignment attribute for bars
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum BarAlignment: String, CaseIterable, Hashable, Codable {
    case leading
    case center
    case trailing
    
    public var description: String {
        rawValue.capitalized
    }
}
