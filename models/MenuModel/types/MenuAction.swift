import Foundation

/// Action type for menus
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct MenuAction: Hashable, Codable, Identifiable {
    public let id: UUID
    public let type: ActionType
    public let handler: String
    
    public enum ActionType: String, CaseIterable, Hashable, Codable {
        case open
        case close
        case select
        case dismiss
        case navigate
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
