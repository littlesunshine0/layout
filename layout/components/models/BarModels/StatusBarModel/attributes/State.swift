import Foundation

/// Status bar state attribute
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum StatusBarState {
    case visible
    case hidden
    case autoHide
    case updating
}
