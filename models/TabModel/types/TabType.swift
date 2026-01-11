import Foundation

/// Tab type definition
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum TabType: String, CaseIterable, Hashable, Codable {
    case horizontal
    case vertical
    case segmented
    case pills
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultHeight: CGFloat {
        switch self {
        case .horizontal: return 44.0
        case .vertical: return 0 // Auto-height
        case .segmented: return 32.0
        case .pills: return 36.0
        }
    }
}
