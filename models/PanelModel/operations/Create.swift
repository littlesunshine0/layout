import Foundation

/// Create operation for panels
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct PanelCreate {
    
    /// Create a panel with default settings for the given type
    public static func execute(type: PanelType) -> PanelModel {
        PanelModel(
            id: UUID(),
            type: type,
            alignment: .leading,
            position: .leadingTop,
            visibility: .visible,
            state: .normal
        )
    }
    
    /// Create a panel with custom configuration
    public static func execute(
        type: PanelType,
        alignment: PanelAlignment,
        position: PanelPosition,
        visibility: PanelVisibility
    ) -> PanelModel {
        PanelModel(
            id: UUID(),
            type: type,
            alignment: alignment,
            position: position,
            visibility: visibility,
            state: .normal
        )
    }
    
    /// Create a panel from properties dictionary
    public static func execute(type: PanelType, properties: [String: Any]) -> PanelModel {
        let alignment = PanelAlignment(rawValue: properties["alignment"] as? String ?? "leading") ?? .leading
        let isVisible = properties["isVisible"] as? Bool ?? true
        
        return PanelModel(
            id: UUID(),
            type: type,
            alignment: alignment,
            position: .leadingTop,
            visibility: PanelVisibility(isVisible: isVisible),
            state: .normal
        )
    }
}

/// Temporary PanelModel struct for reference
private struct PanelModel {
    let id: UUID
    let type: PanelType
    let alignment: PanelAlignment
    let position: PanelPosition
    let visibility: PanelVisibility
    let state: PanelState
}
