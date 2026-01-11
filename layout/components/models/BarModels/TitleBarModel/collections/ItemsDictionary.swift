import Foundation

/// Title bar items dictionary collection
/// Manages key-value pairs of title bar items
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarItemsDictionary {
    private var items: [String: TitleBarItem]
    
    public init(items: [String: TitleBarItem] = [:]) {
        self.items = items
    }
    
    /// Sets an item for key
    public mutating func set(_ item: TitleBarItem, forKey key: String) {
        items[key] = item
    }
    
    /// Gets an item for key
    public func get(forKey key: String) -> TitleBarItem? {
        return items[key]
    }
    
    /// Removes an item for key
    public mutating func remove(forKey key: String) {
        items.removeValue(forKey: key)
    }
    
    /// Checks if key exists
    public func contains(key: String) -> Bool {
        return items.keys.contains(key)
    }
    
    /// Returns all items
    public var all: [String: TitleBarItem] {
        return items
    }
    
    /// Returns all keys
    public var keys: [String] {
        return Array(items.keys)
    }
    
    /// Returns all values
    public var values: [TitleBarItem] {
        return Array(items.values)
    }
    
    /// Returns visible items
    public var visible: [String: TitleBarItem] {
        return items.filter { $0.value.isVisible }
    }
    
    /// Count of items
    public var count: Int {
        return items.count
    }
    
    /// Clears all items
    public mutating func removeAll() {
        items.removeAll()
    }
    
    /// Merges another dictionary
    public mutating func merge(_ other: TitleBarItemsDictionary) {
        items.merge(other.items) { (_, new) in new }
    }
}

/// Title bar item definition
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarItem {
    public let id: UUID
    public var title: String
    public var isVisible: Bool
    public var isEnabled: Bool
    public var metadata: [String: Any]
    
    public init(title: String, isVisible: Bool = true, isEnabled: Bool = true, metadata: [String: Any] = [:]) {
        self.id = UUID()
        self.title = title
        self.isVisible = isVisible
        self.isEnabled = isEnabled
        self.metadata = metadata
    }
}
