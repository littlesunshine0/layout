import Foundation

/// Buttons model create operation
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct ButtonsCreateOperation {
    public static func create(type: ButtonType = .primary) -> ButtonInstance {
        return ButtonInstance(type: type)
    }
}

public enum ButtonType {
    case primary
    case secondary
    case tertiary
    case destructive
    case ghost
}

public class ButtonInstance {
    public let id: UUID
    public var type: ButtonType
    public var isEnabled: Bool
    
    public init(type: ButtonType, isEnabled: Bool = true) {
        self.id = UUID()
        self.type = type
        self.isEnabled = isEnabled
    }
}
