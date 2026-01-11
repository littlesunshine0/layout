import Foundation

/// Card type definition
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum CardType: String, CaseIterable, Hashable, Codable {
    case standard
    case compact
    case featured
    case media
    case info
    case action
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultHeight: CGFloat {
        switch self {
        case .standard: return 120.0
        case .compact: return 80.0
        case .featured: return 240.0
        case .media: return 200.0
        case .info: return 100.0
        case .action: return 60.0
        }
    }
}
