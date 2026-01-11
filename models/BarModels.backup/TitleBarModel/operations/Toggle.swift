import Foundation

/// Toggle operation for TitleBar component
/// Handles toggling of boolean states
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarToggle {
    
    /// Toggles icon visibility
    public static func icon(in model: inout TitleBarModel) {
        model.showsIcon.toggle()
    }
    
    /// Toggles title visibility
    public static func title(in model: inout TitleBarModel) {
        model.showsTitle.toggle()
    }
    
    /// Toggles visibility
    public static func visibility(in model: inout TitleBarModel) {
        model.visibility.isVisible.toggle()
    }
    
    /// Toggles divider
    public static func divider(in model: inout TitleBarModel) {
        model.dividerVisible.toggle()
    }
}
