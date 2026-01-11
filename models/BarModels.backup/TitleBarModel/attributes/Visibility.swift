import Foundation

/// Visibility attribute for TitleBar component
/// Controls whether the title bar is visible
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarVisibility: Codable {
    public var isVisible: Bool
    public var canAutoHide: Bool
    public var autoHideDelay: TimeInterval
    
    public init(isVisible: Bool = true, canAutoHide: Bool = false, autoHideDelay: TimeInterval = 2.0) {
        self.isVisible = isVisible
        self.canAutoHide = canAutoHide
        self.autoHideDelay = autoHideDelay
    }
}
