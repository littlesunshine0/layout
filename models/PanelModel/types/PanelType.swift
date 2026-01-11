import Foundation

/// Defines all panel types in the system
/// Unified panel model with type variants
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum PanelType: String, CaseIterable, Hashable, Codable {
    case side
    case floating
    case preview
    case category
    
    public var description: String {
        switch self {
        case .side:
            return "Side Panel"
        case .floating:
            return "Floating Panel"
        case .preview:
            return "Preview Panel"
        case .category:
            return "Category Panel"
        }
    }
    
    public var defaultWidth: CGFloat {
        switch self {
        case .side:
            return 250.0
        case .floating:
            return 320.0
        case .preview:
            return 400.0
        case .category:
            return 280.0
        }
    }
    
    public var canResize: Bool {
        switch self {
        case .side, .floating, .preview:
            return true
        case .category:
            return false
        }
    }
    
    public var supportsDetachment: Bool {
        switch self {
        case .floating, .preview:
            return true
        case .side, .category:
            return false
        }
    }
}
