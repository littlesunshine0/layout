import Foundation

/// Defines all bar types in the system
/// Instead of separate models, bars are unified with type variants
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum BarType: String, CaseIterable, Hashable, Codable {
    case title
    case status
    case path
    case tool
    case breadcrumbs
    
    public var description: String {
        switch self {
        case .title:
            return "Title Bar"
        case .status:
            return "Status Bar"
        case .path:
            return "Path Bar"
        case .tool:
            return "Toolbar"
        case .breadcrumbs:
            return "Breadcrumbs Bar"
        }
    }
    
    public var defaultHeight: CGFloat {
        switch self {
        case .title:
            return 44.0
        case .status:
            return 20.0
        case .path:
            return 28.0
        case .tool:
            return 44.0
        case .breadcrumbs:
            return 32.0
        }
    }
    
    public var supportsCustomization: Bool {
        switch self {
        case .title, .tool:
            return true
        case .status, .path, .breadcrumbs:
            return false
        }
    }
}
