import Foundation

/// Action type for controls
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct ControlAction: Hashable, Codable, Identifiable {
    public let id: UUID
    public let type: ActionType
    public let handler: String
    
    public enum ActionType: String, CaseIterable, Hashable, Codable {
        case tap
        case press
        case release
        case longPress
        case increment
        case decrement
        case toggle
        case change
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
