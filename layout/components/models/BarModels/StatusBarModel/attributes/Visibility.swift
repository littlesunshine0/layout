import Foundation

/// Status bar visibility attribute
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct StatusBarVisibility {
    public var isVisible: Bool
    public var autoHide: Bool
    public var delay: TimeInterval
    
    public init(isVisible: Bool = true, autoHide: Bool = false, delay: TimeInterval = 3.0) {
        self.isVisible = isVisible
        self.autoHide = autoHide
        self.delay = delay
    }
}
