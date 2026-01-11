import Foundation

/// TitleBarStyle type definition
/// Defines visual style variations for the title bar
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum TitleBarStyle: String, Codable, CaseIterable {
    case standard
    case unified
    case compact
    case large
    case transparent
    case blurred
    
    public var description: String {
        switch self {
        case .standard: return "Standard"
        case .unified: return "Unified"
        case .compact: return "Compact"
        case .large: return "Large"
        case .transparent: return "Transparent"
        case .blurred: return "Blurred"
        }
    }
    
    public var defaultHeight: Double {
        switch self {
        case .standard: return 52
        case .unified: return 44
        case .compact: return 32
        case .large: return 72
        case .transparent: return 52
        case .blurred: return 52
        }
    }
}
