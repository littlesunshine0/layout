import Foundation

/// Menu type definition
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum MenuType: String, CaseIterable, Hashable, Codable {
    case context
    case dropdown
    case bento
    case hamburger
    case popup
    case action
    case contextual
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultWidth: CGFloat {
        switch self {
        case .context: return 200.0
        case .dropdown: return 180.0
        case .bento: return 300.0
        case .hamburger: return 250.0
        case .popup: return 220.0
        case .action: return 160.0
        case .contextual: return 200.0
        }
    }
    
    public var supportsNesting: Bool {
        switch self {
        case .context, .dropdown, .hamburger:
            return true
        default:
            return false
        }
    }
}
