import Foundation

/// Collection of bar actions
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct BarActionsSet: Hashable, Codable {
    private var actions: Set<BarAction>
    
    public init(_ actions: Set<BarAction> = []) {
        self.actions = actions
    }
    
    public mutating func add(_ action: BarAction) {
        actions.insert(action)
    }
    
    public mutating func remove(_ action: BarAction) {
        actions.remove(action)
    }
    
    public func contains(_ action: BarAction) -> Bool {
        actions.contains(action)
    }
    
    public var count: Int {
        actions.count
    }
    
    public func actions(ofType type: BarAction.ActionType) -> [BarAction] {
        actions.filter { $0.type == type }
    }
}
