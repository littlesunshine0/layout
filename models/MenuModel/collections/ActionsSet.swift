import Foundation

/// Collection of menu actions
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct MenuActionsSet: Hashable, Codable {
    private var actions: Set<MenuAction>
    
    public init(_ actions: Set<MenuAction> = []) {
        self.actions = actions
    }
    
    public mutating func add(_ action: MenuAction) {
        actions.insert(action)
    }
    
    public mutating func remove(_ action: MenuAction) {
        actions.remove(action)
    }
    
    public func contains(_ action: MenuAction) -> Bool {
        actions.contains(action)
    }
    
    public var count: Int {
        actions.count
    }
    
    public func actions(ofType type: MenuAction.ActionType) -> [MenuAction] {
        actions.filter { $0.type == type }
    }
}
