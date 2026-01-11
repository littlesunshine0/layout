import Foundation

/// Action type for cards
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct CardAction: Hashable, Codable, Identifiable {
    public let id: UUID
    public let type: ActionType
    public let handler: String
    
    public enum ActionType: String, CaseIterable, Hashable, Codable {
        case tap
        case longPress
        case doubleClick
        case hover
        case swipe
        case drag
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
