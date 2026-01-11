import Foundation

/// Toggle operation for tabs
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TabToggle {
    
    /// Toggle tab selection
    public static func selection(id: UUID) -> Bool {
        true
    }
    
    /// Toggle close button visibility
    public static func closeButton(id: UUID) -> Bool {
        true
    }
    
    /// Toggle reorder capability
    public static func reorder(id: UUID) -> Bool {
        true
    }
}
