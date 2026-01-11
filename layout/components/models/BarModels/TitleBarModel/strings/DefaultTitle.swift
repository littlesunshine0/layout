import Foundation

/// Title bar default title strings
/// Centralized string constants for default titles
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarDefaultTitle {
    
    /// Default untitled window title
    public static let untitled = "Untitled"
    
    /// Numbered untitled titles
    public static func untitled(number: Int) -> String {
        return "Untitled \(number)"
    }
    
    /// Default application title
    public static let application = "Application"
    
    /// Default document title
    public static let document = "Document"
    
    /// Default window title
    public static let window = "Window"
    
    /// Default editor title
    public static let editor = "Editor"
    
    /// Default viewer title
    public static let viewer = "Viewer"
    
    /// Default preview title
    public static let preview = "Preview"
    
    /// Default settings title
    public static let settings = "Settings"
    
    /// Default preferences title
    public static let preferences = "Preferences"
    
    /// Localized default titles
    public static var localizedUntitled: String {
        NSLocalizedString("Untitled", comment: "Default untitled window title")
    }
    
    public static var localizedDocument: String {
        NSLocalizedString("Document", comment: "Default document title")
    }
}

/// Title bar title formatting utilities
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarTitleFormatter {
    
    /// Formats title with prefix
    public static func withPrefix(_ prefix: String, title: String) -> String {
        return "\(prefix): \(title)"
    }
    
    /// Formats title with suffix
    public static func withSuffix(_ title: String, suffix: String) -> String {
        return "\(title) - \(suffix)"
    }
    
    /// Formats title with modified indicator
    public static func withModifiedIndicator(_ title: String, isModified: Bool) -> String {
        return isModified ? "• \(title)" : title
    }
}
