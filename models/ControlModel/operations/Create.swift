import Foundation

/// Create operation for controls
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct ControlCreate {
    
    /// Create a control with default settings
    public static func execute(type: ControlType) -> ControlModel {
        ControlModel(
            id: UUID(),
            type: type,
            state: .normal,
            size: .medium,
            variant: .primary,
            alignment: .center
        )
    }
    
    /// Create a control with custom configuration
    public static func execute(
        type: ControlType,
        size: ControlSize,
        variant: ControlVariant,
        alignment: ControlAlignment
    ) -> ControlModel {
        ControlModel(
            id: UUID(),
            type: type,
            state: .normal,
            size: size,
            variant: variant,
            alignment: alignment
        )
    }
    
    /// Create a control from properties
    public static func execute(type: ControlType, properties: [String: Any]) -> ControlModel {
        let size = ControlSize(rawValue: properties["size"] as? String ?? "medium") ?? .medium
        let variant = ControlVariant(rawValue: properties["variant"] as? String ?? "primary") ?? .primary
        
        return ControlModel(
            id: UUID(),
            type: type,
            state: .normal,
            size: size,
            variant: variant,
            alignment: .center
        )
    }
}

/// Temporary ControlModel struct
private struct ControlModel {
    let id: UUID
    let type: ControlType
    let state: ControlState
    let size: ControlSize
    let variant: ControlVariant
    let alignment: ControlAlignment
}
