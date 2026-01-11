import Foundation

/// Create operation for bars
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct BarCreate {
    
    /// Create a bar with default settings for the given type
    public static func execute(type: BarType) -> BarModel {
        BarModel(
            id: UUID(),
            type: type,
            alignment: .leading,
            position: type == .status ? .top : .top,
            visibility: .alwaysVisible,
            state: .normal
        )
    }
    
    /// Create a bar with custom configuration
    public static func execute(
        type: BarType,
        alignment: BarAlignment,
        position: BarPosition,
        visibility: BarVisibility
    ) -> BarModel {
        BarModel(
            id: UUID(),
            type: type,
            alignment: alignment,
            position: position,
            visibility: visibility,
            state: .normal
        )
    }
    
    /// Create a bar from properties dictionary
    public static func execute(type: BarType, properties: [String: Any]) -> BarModel {
        let alignment = BarAlignment(rawValue: properties["alignment"] as? String ?? "leading") ?? .leading
        let position = BarPosition(rawValue: properties["position"] as? String ?? "top") ?? .top
        let isVisible = properties["isVisible"] as? Bool ?? true
        
        return BarModel(
            id: UUID(),
            type: type,
            alignment: alignment,
            position: position,
            visibility: BarVisibility(isVisible: isVisible),
            state: .normal
        )
    }
}

/// Temporary BarModel struct for reference
private struct BarModel {
    let id: UUID
    let type: BarType
    let alignment: BarAlignment
    let position: BarPosition
    let visibility: BarVisibility
    let state: BarState
}
