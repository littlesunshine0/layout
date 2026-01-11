import Foundation

/// TitleBarAction type definition
/// Defines actions that can be performed on the title bar
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarAction: Codable {
    public let id: String
    public let type: ActionType
    public let handler: String  // Reference to handler function
    
    public enum ActionType: String, Codable {
        case buttonTap
        case doubleClick
        case drag
        case contextMenu
    }
    
    public init(id: String = UUID().uuidString, type: ActionType, handler: String) {
        self.id = id
        self.type = type
        self.handler = handler
    }
}
