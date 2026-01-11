import Foundation

/// Title bar actions set collection
/// Manages unique set of title bar actions
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarActionsSet {
    private var actions: Set<TitleBarAction>
    
    public init(actions: Set<TitleBarAction> = []) {
        self.actions = actions
    }
    
    /// Adds an action to the set
    public mutating func add(_ action: TitleBarAction) {
        actions.insert(action)
    }
    
    /// Removes an action from the set
    public mutating func remove(_ action: TitleBarAction) {
        actions.remove(action)
    }
    
    /// Checks if action exists
    public func contains(_ action: TitleBarAction) -> Bool {
        return actions.contains(action)
    }
    
    /// Returns all actions
    public var all: Set<TitleBarAction> {
        return actions
    }
    
    /// Returns enabled actions
    public var enabled: Set<TitleBarAction> {
        return actions.filter { $0.isEnabled }
    }
    
    /// Count of actions
    public var count: Int {
        return actions.count
    }
    
    /// Clears all actions
    public mutating func removeAll() {
        actions.removeAll()
    }
    
    /// Executes all enabled actions
    public func executeAll() {
        enabled.forEach { $0.execute() }
    }
}

/// Title bar action definition
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarAction: Hashable {
    public let id: UUID
    public let name: String
    public let handler: () -> Void
    public var isEnabled: Bool
    
    public init(name: String, isEnabled: Bool = true, handler: @escaping () -> Void) {
        self.id = UUID()
        self.name = name
        self.isEnabled = isEnabled
        self.handler = handler
    }
    
    public func execute() {
        guard isEnabled else { return }
        handler()
    }
    
    // Hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: TitleBarAction, rhs: TitleBarAction) -> Bool {
        return lhs.id == rhs.id
    }
}
