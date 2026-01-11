import Foundation

/// Visibility attribute for panels
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct PanelVisibility: Hashable, Codable {
    public var isVisible: Bool
    public var canCollapse: Bool
    public var isCollapsed: Bool
    
    public init(
        isVisible: Bool = true,
        canCollapse: Bool = true,
        isCollapsed: Bool = false
    ) {
        self.isVisible = isVisible
        self.canCollapse = canCollapse
        self.isCollapsed = isCollapsed
    }
    
    public static let visible = PanelVisibility(isVisible: true, canCollapse: true, isCollapsed: false)
    public static let collapsed = PanelVisibility(isVisible: true, canCollapse: true, isCollapsed: true)
    public static let hidden = PanelVisibility(isVisible: false, canCollapse: false, isCollapsed: false)
}
