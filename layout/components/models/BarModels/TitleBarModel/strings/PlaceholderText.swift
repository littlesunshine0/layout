import Foundation

/// Title bar placeholder text strings
/// Centralized placeholder text constants
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarPlaceholder {
    
    /// Search placeholder
    public static let search = "Search..."
    
    /// Title input placeholder
    public static let enterTitle = "Enter title..."
    
    /// Empty state placeholder
    public static let noTitle = "No title"
    
    /// Loading placeholder
    public static let loading = "Loading..."
    
    /// Filter placeholder
    public static let filter = "Filter..."
    
    /// Generic placeholder
    public static let placeholder = "Placeholder"
    
    /// Localized placeholders
    public static var localizedSearch: String {
        NSLocalizedString("Search...", comment: "Search placeholder")
    }
    
    public static var localizedEnterTitle: String {
        NSLocalizedString("Enter title...", comment: "Title input placeholder")
    }
    
    public static var localizedLoading: String {
        NSLocalizedString("Loading...", comment: "Loading placeholder")
    }
}
