import Foundation

/// Display type definition
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum DisplayType: String, CaseIterable, Hashable, Codable {
    case badge
    case chart
    case feed
    case widget
    case avatar
    case indicator
    case progress
    case sparkline
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultSize: CGFloat {
        switch self {
        case .badge: return 20.0
        case .chart: return 200.0
        case .feed: return 300.0
        case .widget: return 150.0
        case .avatar: return 40.0
        case .indicator: return 16.0
        case .progress: return 4.0
        case .sparkline: return 50.0
        }
    }
    
    public var supportsInteraction: Bool {
        switch self {
        case .feed, .widget, .chart:
            return true
        default:
            return false
        }
    }
}
