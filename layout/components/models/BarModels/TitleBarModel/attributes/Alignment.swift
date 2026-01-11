import Foundation

/// Title bar alignment attribute
/// Defines horizontal and vertical alignment options for title bar content
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarAlignment {
    case leading
    case center
    case trailing
    case justified
    
    public var description: String {
        switch self {
        case .leading: return "Leading"
        case .center: return "Center"
        case .trailing: return "Trailing"
        case .justified: return "Justified"
        }
    }
}

/// Title bar content alignment configuration
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarAlignmentConfig {
    public var horizontal: TitleBarAlignment
    public var vertical: VerticalAlignment
    
    public enum VerticalAlignment {
        case top
        case center
        case bottom
    }
    
    public init(horizontal: TitleBarAlignment = .center, vertical: VerticalAlignment = .center) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}
