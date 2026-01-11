import Foundation

/// Menu item type
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct MenuItem: Hashable, Codable, Identifiable {
    public let id: UUID
    public let title: String
    public let icon: String?
    public let action: String
    public let isEnabled: Bool
    public let isDivider: Bool
    public let children: [MenuItem]?
    
    public init(
        id: UUID = UUID(),
        title: String,
        icon: String? = nil,
        action: String = "",
        isEnabled: Bool = true,
        isDivider: Bool = false,
        children: [MenuItem]? = nil
    ) {
        self.id = id
        self.title = title
        self.icon = icon
        self.action = action
        self.isEnabled = isEnabled
        self.isDivider = isDivider
        self.children = children
    }
    
    public static let divider = MenuItem(title: "", isDivider: true)
}
