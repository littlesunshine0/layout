import Foundation

/// Create operation for TitleBar component
/// Handles creation of new title bar instances
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarCreate {
    
    /// Creates a new title bar with default configuration
    public static func execute() -> TitleBarModel {
        return TitleBarModel.default()
    }
    
    /// Creates a new title bar with custom configuration
    public static func execute(
        title: String,
        showsIcon: Bool = true,
        buttons: [TitleBarButton] = [.close, .minimize, .maximize]
    ) -> TitleBarModel {
        var model = TitleBarModel.default()
        model.title = title
        model.showsIcon = showsIcon
        model.buttons = buttons
        return model
    }
    
    /// Creates a new title bar from property files
    public static func fromProperties() -> TitleBarModel {
        return TitleBarModel.fromProperties()
    }
}
