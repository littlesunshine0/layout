import Foundation

/// Title bar error message strings
/// Centralized error message constants
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarErrorMessage {
    
    /// Validation errors
    public static let invalidHeight = "Invalid height: must be between 22 and 100 pixels"
    public static let emptyTitle = "Title cannot be empty"
    public static let titleTooLong = "Title is too long (maximum 255 characters)"
    
    /// Operation errors
    public static let creationFailed = "Failed to create title bar"
    public static let updateFailed = "Failed to update title bar"
    public static let deleteFailed = "Failed to delete title bar"
    
    /// State errors
    public static let invalidState = "Invalid title bar state"
    public static let invalidTransition = "Invalid state transition"
    
    /// Configuration errors
    public static let invalidConfiguration = "Invalid title bar configuration"
    public static let missingConfiguration = "Missing title bar configuration"
    
    /// Instance errors
    public static let instanceNotFound = "Title bar instance not found"
    public static let instanceAlreadyExists = "Title bar instance already exists"
    
    /// Localized error messages
    public static func localizedError(for error: ValidationError) -> String {
        switch error {
        case .invalidHeight(let height):
            return String(format: NSLocalizedString("Invalid height: %.1f (must be 22-100)", comment: ""), height)
        case .emptyTitle:
            return NSLocalizedString("Title cannot be empty", comment: "")
        case .titleTooLong(let count):
            return String(format: NSLocalizedString("Title too long: %d characters (max 255)", comment: ""), count)
        case .instanceNotFound:
            return NSLocalizedString("Title bar not found", comment: "")
        case .invalidStateTransition:
            return NSLocalizedString("Invalid state transition", comment: "")
        }
    }
}
