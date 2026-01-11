import Foundation

/// Visibility attribute for bars
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct BarVisibility: Hashable, Codable {
    public var isVisible: Bool
    public var canAutoHide: Bool
    public var autoHideDelay: TimeInterval
    
    public init(
        isVisible: Bool = true,
        canAutoHide: Bool = false,
        autoHideDelay: TimeInterval = 3.0
    ) {
        self.isVisible = isVisible
        self.canAutoHide = canAutoHide
        self.autoHideDelay = autoHideDelay
    }
    
    public static let alwaysVisible = BarVisibility(isVisible: true, canAutoHide: false)
    public static let autoHiding = BarVisibility(isVisible: true, canAutoHide: true)
    public static let hidden = BarVisibility(isVisible: false, canAutoHide: false)
}
