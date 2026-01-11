import Foundation

/// Collection of tab actions
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TabActionsSet: Hashable, Codable {
    private var actions: Set<TabAction>
    
    public init(_ actions: Set<TabAction> = []) {
        self.actions = actions
    }
    
    public mutating func add(_ action: TabAction) {
        actions.insert(action)
    }
    
    public mutating func remove(_ action: TabAction) {
        actions.remove(action)
    }
    
    public func contains(_ action: TabAction) -> Bool {
        actions.contains(action)
    }
    
    public var count: Int {
        actions.count
    }
    
    public func actions(ofType type: TabAction.ActionType) -> [TabAction] {
        actions.filter { $0.type == type }
    }
}
