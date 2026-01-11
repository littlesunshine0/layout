import Foundation

/// Alignment attribute for TitleBar component
/// Defines how content is aligned within the title bar
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum TitleBarAlignment: String, Codable, CaseIterable {
    case leading
    case center
    case trailing
    
    public var description: String {
        switch self {
        case .leading: return "Leading"
        case .center: return "Center"
        case .trailing: return "Trailing"
        }
    }
}
