import Foundation

/// Create operation for tabs
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TabCreate {
    
    /// Create a tab with default settings
    public static func execute(type: TabType) -> TabModel {
        TabModel(
            id: UUID(),
            type: type,
            alignment: .leading,
            position: .top,
            state: .normal,
            selection: .single
        )
    }
    
    /// Create a tab with custom configuration
    public static func execute(
        type: TabType,
        alignment: TabAlignment,
        position: TabPosition,
        selection: TabSelection
    ) -> TabModel {
        TabModel(
            id: UUID(),
            type: type,
            alignment: alignment,
            position: position,
            state: .normal,
            selection: selection
        )
    }
    
    /// Create a tab from properties
    public static func execute(type: TabType, properties: [String: Any]) -> TabModel {
        let alignment = TabAlignment(rawValue: properties["alignment"] as? String ?? "leading") ?? .leading
        let position = TabPosition(rawValue: properties["position"] as? String ?? "top") ?? .top
        
        return TabModel(
            id: UUID(),
            type: type,
            alignment: alignment,
            position: position,
            state: .normal,
            selection: .single
        )
    }
}

/// Temporary TabModel struct
private struct TabModel {
    let id: UUID
    let type: TabType
    let alignment: TabAlignment
    let position: TabPosition
    let state: TabState
    let selection: TabSelection
}
