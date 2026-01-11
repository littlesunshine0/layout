import Foundation

/// Actions set collection for TitleBar
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarActionsSet {
    private var actions: Set<TitleBarActionWrapper>
    
    public init() {
        self.actions = []
    }
    
    public mutating func add(_ action: TitleBarAction) {
        actions.insert(TitleBarActionWrapper(action: action))
    }
    
    public mutating func remove(id: String) {
        actions.removeAll { $0.action.id == id }
    }
    
    public func get(id: String) -> TitleBarAction? {
        actions.first { $0.action.id == id }?.action
    }
    
    public func getAll(ofType type: TitleBarAction.ActionType) -> [TitleBarAction] {
        actions.filter { $0.action.type == type }.map { $0.action }
    }
    
    public var count: Int {
        actions.count
    }
}

// Wrapper to make TitleBarAction hashable
private struct TitleBarActionWrapper: Hashable {
    let action: TitleBarAction
    
    static func == (lhs: TitleBarActionWrapper, rhs: TitleBarActionWrapper) -> Bool {
        lhs.action.id == rhs.action.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(action.id)
    }
}
