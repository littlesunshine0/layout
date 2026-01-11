import Foundation

/// Title bar buttons array collection
/// Manages ordered collection of title bar buttons
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarButtonsArray {
    private var buttons: [TitleBarButtonConfig]
    
    public init(buttons: [TitleBarButtonConfig] = []) {
        self.buttons = buttons
    }
    
    /// Adds a button to the array
    public mutating func add(_ button: TitleBarButtonConfig) {
        buttons.append(button)
    }
    
    /// Inserts a button at specific index
    public mutating func insert(_ button: TitleBarButtonConfig, at index: Int) {
        guard index >= 0 && index <= buttons.count else { return }
        buttons.insert(button, at: index)
    }
    
    /// Removes a button at index
    public mutating func remove(at index: Int) {
        guard index >= 0 && index < buttons.count else { return }
        buttons.remove(at: index)
    }
    
    /// Gets button at index
    public func button(at index: Int) -> TitleBarButtonConfig? {
        guard index >= 0 && index < buttons.count else { return nil }
        return buttons[index]
    }
    
    /// Updates button at index
    public mutating func update(_ button: TitleBarButtonConfig, at index: Int) {
        guard index >= 0 && index < buttons.count else { return }
        buttons[index] = button
    }
    
    /// Returns all buttons
    public var all: [TitleBarButtonConfig] {
        return buttons
    }
    
    /// Returns visible buttons
    public var visible: [TitleBarButtonConfig] {
        return buttons.filter { $0.isVisible }
    }
    
    /// Returns enabled buttons
    public var enabled: [TitleBarButtonConfig] {
        return buttons.filter { $0.isEnabled }
    }
    
    /// Count of buttons
    public var count: Int {
        return buttons.count
    }
    
    /// Clears all buttons
    public mutating func removeAll() {
        buttons.removeAll()
    }
    
    /// Filters buttons by predicate
    public func filter(_ predicate: (TitleBarButtonConfig) -> Bool) -> [TitleBarButtonConfig] {
        return buttons.filter(predicate)
    }
}
