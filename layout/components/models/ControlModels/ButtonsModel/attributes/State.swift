import Foundation

/// Button state attribute
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum ButtonState {
    case normal
    case hovered
    case pressed
    case disabled
    case focused
}
