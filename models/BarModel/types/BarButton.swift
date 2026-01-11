import Foundation

/// Button type for bars
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum BarButton: String, CaseIterable, Hashable, Codable {
    case close
    case minimize
    case maximize
    case settings
    case help
    case fullscreen
    case share
    case refresh
    case back
    case forward
    case custom
    
    public var icon: String {
        switch self {
        case .close: return "xmark"
        case .minimize: return "minus"
        case .maximize: return "arrow.up.left.and.arrow.down.right"
        case .settings: return "gearshape"
        case .help: return "questionmark.circle"
        case .fullscreen: return "arrow.up.left.and.arrow.down.right.square"
        case .share: return "square.and.arrow.up"
        case .refresh: return "arrow.clockwise"
        case .back: return "chevron.left"
        case .forward: return "chevron.right"
        case .custom: return "circle"
        }
    }
}
