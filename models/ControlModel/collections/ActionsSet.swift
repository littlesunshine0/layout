import Foundation

/// Collection of control actions
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct ControlActionsSet: Hashable, Codable {
    private var actions: Set<ControlAction>
    
    public init(_ actions: Set<ControlAction> = []) {
        self.actions = actions
    }
    
    public mutating func add(_ action: ControlAction) {
        actions.insert(action)
    }
    
    public mutating func remove(_ action: ControlAction) {
        actions.remove(action)
    }
    
    public func contains(_ action: ControlAction) -> Bool {
        actions.contains(action)
    }
    
    public var count: Int {
        actions.count
    }
    
    public func actions(ofType type: ControlAction.ActionType) -> [ControlAction] {
        actions.filter { $0.type == type }
    }
}
