import Foundation

/// Title bar alignment type definition
/// Comprehensive alignment options for title bar elements
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarHorizontalAlignment {
    case leading
    case center
    case trailing
    
    public var cgFloatValue: CGFloat {
        switch self {
        case .leading: return 0.0
        case .center: return 0.5
        case .trailing: return 1.0
        }
    }
}

/// Title bar vertical alignment
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarVerticalAlignment {
    case top
    case center
    case bottom
    
    public var cgFloatValue: CGFloat {
        switch self {
        case .top: return 0.0
        case .center: return 0.5
        case .bottom: return 1.0
        }
    }
}

/// Title bar text alignment
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarTextAlignment {
    case left
    case center
    case right
    case natural
    case justified
    
    #if canImport(UIKit)
    import UIKit
    public var textAlignment: NSTextAlignment {
        switch self {
        case .left: return .left
        case .center: return .center
        case .right: return .right
        case .natural: return .natural
        case .justified: return .justified
        }
    }
    #endif
}
