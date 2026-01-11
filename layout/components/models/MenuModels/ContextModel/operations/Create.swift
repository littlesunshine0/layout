import Foundation

/// Context menu create operation
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct ContextMenuCreateOperation {
    public static func create(items: [ContextMenuItem] = []) -> ContextMenuInstance {
        return ContextMenuInstance(items: items)
    }
}

public struct ContextMenuItem {
    public var title: String
    public var action: () -> Void
    public var isEnabled: Bool
    
    public init(title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
    }
}

public class ContextMenuInstance {
    public let id: UUID
    public var items: [ContextMenuItem]
    
    public init(items: [ContextMenuItem]) {
        self.id = UUID()
        self.items = items
    }
}
