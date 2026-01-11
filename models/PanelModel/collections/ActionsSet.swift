import Foundation

/// Collection of panel actions
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct PanelActionsSet: Hashable, Codable {
    private var actions: Set<PanelAction>
    
    public init(_ actions: Set<PanelAction> = []) {
        self.actions = actions
    }
    
    public mutating func add(_ action: PanelAction) {
        actions.insert(action)
    }
    
    public mutating func remove(_ action: PanelAction) {
        actions.remove(action)
    }
    
    public func contains(_ action: PanelAction) -> Bool {
        actions.contains(action)
    }
    
    public var count: Int {
        actions.count
    }
    
    public func actions(ofType type: PanelAction.ActionType) -> [PanelAction] {
        actions.filter { $0.type == type }
    }
}
