import Foundation

/// Action type for panels
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct PanelAction: Hashable, Codable, Identifiable {
    public let id: UUID
    public let type: ActionType
    public let handler: String
    
    public enum ActionType: String, CaseIterable, Hashable, Codable {
        case tap
        case drag
        case resize
        case collapse
        case detach
        case close
        case custom
    }
    
    public init(
        id: UUID = UUID(),
        type: ActionType,
        handler: String
    ) {
        self.id = id
        self.type = type
        self.handler = handler
    }
}
