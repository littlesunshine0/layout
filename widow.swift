import Foundation

/// Main window management module
/// This module provides a comprehensive system for managing window properties and behavior
struct Widow {
    // Window properties can be accessed and modified through this interface
    
    static let shared = Widow()
    
    private init() {}
    
    /// Returns a list of all available window properties
    func availableProperties() -> [String] {
        return [
            "WindowTitle",
            "WindowIsVisible",
            "WindowFrame",
            "WindowIsResizable",
            "WindowIsMinimizable",
            "WindowIsClosable",
            "WindowIsFullScreen",
            "WindowAlphaValue",
            "WindowBackgroundColor",
            "WindowCollectionBehavior",
            "WindowStyleMask",
            "WindowLevel",
            "WindowAspectRatio",
            "WindowHasToolbar",
            "ToolbarStyle",
            "WindowStyle",
            "WindowHidesOnDeactivate",
            "WindowRestorationBehavior",
            "WindowContentAspectRatio"
        ]
    }
}
