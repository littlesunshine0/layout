import Foundation

/// Create operation for displays
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct DisplayCreate {
    
    /// Create a display with default settings
    public static func execute(type: DisplayType) -> DisplayModel {
        DisplayModel(
            id: UUID(),
            type: type,
            state: .normal,
            format: .text,
            colorScheme: .primary,
            size: .medium
        )
    }
    
    /// Create a display with custom configuration
    public static func execute(
        type: DisplayType,
        format: DisplayFormat,
        colorScheme: DisplayColorScheme,
        size: DisplaySize
    ) -> DisplayModel {
        DisplayModel(
            id: UUID(),
            type: type,
            state: .normal,
            format: format,
            colorScheme: colorScheme,
            size: size
        )
    }
    
    /// Create a display from properties
    public static func execute(type: DisplayType, properties: [String: Any]) -> DisplayModel {
        let format = DisplayFormat(rawValue: properties["format"] as? String ?? "text") ?? .text
        let colorScheme = DisplayColorScheme(rawValue: properties["colorScheme"] as? String ?? "primary") ?? .primary
        
        return DisplayModel(
            id: UUID(),
            type: type,
            state: .normal,
            format: format,
            colorScheme: colorScheme,
            size: .medium
        )
    }
}

/// Temporary DisplayModel struct
private struct DisplayModel {
    let id: UUID
    let type: DisplayType
    let state: DisplayState
    let format: DisplayFormat
    let colorScheme: DisplayColorScheme
    let size: DisplaySize
}
