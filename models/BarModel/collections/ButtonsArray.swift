import Foundation

/// Collection of bar buttons
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct BarButtonsArray: Hashable, Codable {
    private var buttons: [BarButton]
    
    public init(_ buttons: [BarButton] = []) {
        self.buttons = buttons
    }
    
    public mutating func add(_ button: BarButton) {
        buttons.append(button)
    }
    
    public mutating func remove(_ button: BarButton) {
        buttons.removeAll { $0 == button }
    }
    
    public func contains(_ button: BarButton) -> Bool {
        buttons.contains(button)
    }
    
    public var count: Int {
        buttons.count
    }
    
    // Presets
    public static let defaultButtons = BarButtonsArray([.close, .minimize, .maximize])
    public static let minimalButtons = BarButtonsArray([.close])
    public static let fullButtons = BarButtonsArray([.close, .minimize, .maximize, .fullscreen])
    public static let toolButtons = BarButtonsArray([.back, .forward, .refresh, .share])
}
