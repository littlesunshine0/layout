import Foundation

/// Title bar button label strings
/// Centralized button label and accessibility text constants
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarButtonLabel {
    
    /// Standard window control button labels
    public static let close = "Close"
    public static let minimize = "Minimize"
    public static let maximize = "Maximize"
    public static let restore = "Restore"
    public static let fullscreen = "Enter Fullscreen"
    public static let exitFullscreen = "Exit Fullscreen"
    
    /// Additional control labels
    public static let menu = "Menu"
    public static let more = "More"
    public static let settings = "Settings"
    public static let help = "Help"
    public static let share = "Share"
    
    /// Accessibility labels
    public static let closeAccessibility = "Close window"
    public static let minimizeAccessibility = "Minimize window"
    public static let maximizeAccessibility = "Maximize window"
    public static let fullscreenAccessibility = "Toggle fullscreen mode"
    
    /// Localized button labels
    public static var localizedClose: String {
        NSLocalizedString("Close", comment: "Close button label")
    }
    
    public static var localizedMinimize: String {
        NSLocalizedString("Minimize", comment: "Minimize button label")
    }
    
    public static var localizedMaximize: String {
        NSLocalizedString("Maximize", comment: "Maximize button label")
    }
    
    public static var localizedFullscreen: String {
        NSLocalizedString("Enter Fullscreen", comment: "Fullscreen button label")
    }
    
    /// Tooltip text
    public enum Tooltip {
        public static let close = "Close this window"
        public static let minimize = "Minimize to dock"
        public static let maximize = "Maximize window"
        public static let fullscreen = "Enter fullscreen mode"
    }
}
