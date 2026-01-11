import Foundation

/// Error message string constants for TitleBar
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarErrors {
    public static let invalidHeight = "Title bar height must be between 24 and 200 points"
    public static let invalidColor = "Invalid color format. Use hex format like #1C1C1E"
    public static let emptyTitle = "Title cannot be empty"
    public static let noButtons = "At least one button must be configured"
    public static let invalidButton = "Invalid button type specified"
}
