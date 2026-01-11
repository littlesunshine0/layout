import Foundation

/// Collection of card actions
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct CardActionsSet: Hashable, Codable {
    private var actions: Set<CardAction>
    
    public init(_ actions: Set<CardAction> = []) {
        self.actions = actions
    }
    
    public mutating func add(_ action: CardAction) {
        actions.insert(action)
    }
    
    public mutating func remove(_ action: CardAction) {
        actions.remove(action)
    }
    
    public func contains(_ action: CardAction) -> Bool {
        actions.contains(action)
    }
    
    public var count: Int {
        actions.count
    }
    
    public func actions(ofType type: CardAction.ActionType) -> [CardAction] {
        actions.filter { $0.type == type }
    }
}
