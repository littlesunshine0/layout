import Foundation

/// Create operation for menus
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct MenuCreate {
    
    /// Create a menu with default settings
    public static func execute(type: MenuType) -> MenuModel {
        MenuModel(
            id: UUID(),
            type: type,
            state: .closed,
            position: .topLeft,
            animation: .fade,
            alignment: .leading
        )
    }
    
    /// Create a menu with custom configuration
    public static func execute(
        type: MenuType,
        position: MenuPosition,
        animation: MenuAnimation,
        alignment: MenuAlignment
    ) -> MenuModel {
        MenuModel(
            id: UUID(),
            type: type,
            state: .closed,
            position: position,
            animation: animation,
            alignment: alignment
        )
    }
    
    /// Create a menu from properties
    public static func execute(type: MenuType, properties: [String: Any]) -> MenuModel {
        let animation = MenuAnimation(rawValue: properties["animation"] as? String ?? "fade") ?? .fade
        let alignment = MenuAlignment(rawValue: properties["alignment"] as? String ?? "leading") ?? .leading
        
        return MenuModel(
            id: UUID(),
            type: type,
            state: .closed,
            position: .topLeft,
            animation: animation,
            alignment: alignment
        )
    }
}

/// Temporary MenuModel struct
private struct MenuModel {
    let id: UUID
    let type: MenuType
    let state: MenuState
    let position: MenuPosition
    let animation: MenuAnimation
    let alignment: MenuAlignment
}
