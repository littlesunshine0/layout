import Foundation

/// Title bar read operation
/// Handles retrieval and query of title bar data
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarReadOperation {
    
    /// Retrieves title bar by identifier
    public static func read(id: UUID) -> TitleBarInstance? {
        return TitleBarRegistry.shared.getInstance(id: id)
    }
    
    /// Retrieves all title bars
    public static func readAll() -> [TitleBarInstance] {
        return TitleBarRegistry.shared.getAllInstances()
    }
    
    /// Queries title bars by predicate
    public static func query(where predicate: (TitleBarInstance) -> Bool) -> [TitleBarInstance] {
        return TitleBarRegistry.shared.getAllInstances().filter(predicate)
    }
    
    /// Retrieves title bar configuration
    public static func readConfiguration(for id: UUID) -> TitleBarConfiguration? {
        return TitleBarRegistry.shared.getInstance(id: id)?.configuration
    }
    
    /// Retrieves title bar state
    public static func readState(for id: UUID) -> TitleBarState? {
        return TitleBarRegistry.shared.getState(for: id)
    }
}

/// Title bar registry for managing instances
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
internal class TitleBarRegistry {
    static let shared = TitleBarRegistry()
    
    private var instances: [UUID: TitleBarInstance] = [:]
    private var states: [UUID: TitleBarState] = [:]
    
    private init() {}
    
    func getInstance(id: UUID) -> TitleBarInstance? {
        return instances[id]
    }
    
    func getAllInstances() -> [TitleBarInstance] {
        return Array(instances.values)
    }
    
    func register(_ instance: TitleBarInstance) {
        instances[instance.id] = instance
        states[instance.id] = .inactive
    }
    
    func unregister(id: UUID) {
        instances.removeValue(forKey: id)
        states.removeValue(forKey: id)
    }
    
    func getState(for id: UUID) -> TitleBarState? {
        return states[id]
    }
    
    func setState(_ state: TitleBarState, for id: UUID) {
        states[id] = state
    }
}
