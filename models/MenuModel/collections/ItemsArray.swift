import Foundation

/// Collection of menu items
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct MenuItemsArray: Hashable, Codable {
    private var items: [MenuItem]
    
    public init(_ items: [MenuItem] = []) {
        self.items = items
    }
    
    public mutating func add(_ item: MenuItem) {
        items.append(item)
    }
    
    public mutating func remove(_ item: MenuItem) {
        items.removeAll { $0.id == item.id }
    }
    
    public mutating func insert(_ item: MenuItem, at index: Int) {
        guard items.indices.contains(index) else { return }
        items.insert(item, at: index)
    }
    
    public func contains(_ item: MenuItem) -> Bool {
        items.contains { $0.id == item.id }
    }
    
    public var count: Int {
        items.count
    }
    
    public var enabledItems: [MenuItem] {
        items.filter { $0.isEnabled && !$0.isDivider }
    }
    
    public subscript(index: Int) -> MenuItem {
        items[index]
    }
}
