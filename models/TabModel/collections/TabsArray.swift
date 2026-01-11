import Foundation

/// Collection of tabs array
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TabsArray: Hashable, Codable {
    private var tabs: [UUID]
    
    public init(_ tabs: [UUID] = []) {
        self.tabs = tabs
    }
    
    public mutating func add(_ tabId: UUID) {
        tabs.append(tabId)
    }
    
    public mutating func remove(_ tabId: UUID) {
        tabs.removeAll { $0 == tabId }
    }
    
    public mutating func move(from: Int, to: Int) {
        guard from != to, tabs.indices.contains(from), tabs.indices.contains(to) else { return }
        let tab = tabs.remove(at: from)
        tabs.insert(tab, at: to)
    }
    
    public func contains(_ tabId: UUID) -> Bool {
        tabs.contains(tabId)
    }
    
    public var count: Int {
        tabs.count
    }
    
    public subscript(index: Int) -> UUID {
        tabs[index]
    }
}
