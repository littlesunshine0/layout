import Foundation

/// Collection of display actions
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct DisplayActionsSet: Hashable, Codable {
    private var actions: Set<DisplayAction>
    
    public init(_ actions: Set<DisplayAction> = []) {
        self.actions = actions
    }
    
    public mutating func add(_ action: DisplayAction) {
        actions.insert(action)
    }
    
    public mutating func remove(_ action: DisplayAction) {
        actions.remove(action)
    }
    
    public func contains(_ action: DisplayAction) -> Bool {
        actions.contains(action)
    }
    
    public var count: Int {
        actions.count
    }
    
    public func actions(ofType type: DisplayAction.ActionType) -> [DisplayAction] {
        actions.filter { $0.type == type }
    }
}
