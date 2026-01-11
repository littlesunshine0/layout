import Foundation

/// Buttons array collection for TitleBar
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarButtonsArray {
    public var buttons: [TitleBarButton]
    
    public init(buttons: [TitleBarButton] = [.close, .minimize, .maximize]) {
        self.buttons = buttons
    }
    
    public mutating func add(_ button: TitleBarButton) {
        if !buttons.contains(button) {
            buttons.append(button)
        }
    }
    
    public mutating func remove(_ button: TitleBarButton) {
        buttons.removeAll { $0 == button }
    }
    
    public func contains(_ button: TitleBarButton) -> Bool {
        buttons.contains(button)
    }
    
    public static var `default`: TitleBarButtonsArray {
        TitleBarButtonsArray(buttons: [.close, .minimize, .maximize])
    }
    
    public static var minimal: TitleBarButtonsArray {
        TitleBarButtonsArray(buttons: [.close])
    }
    
    public static var full: TitleBarButtonsArray {
        TitleBarButtonsArray(buttons: [.close, .minimize, .maximize, .settings, .help])
    }
}
