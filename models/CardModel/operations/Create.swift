import Foundation

/// Create operation for cards
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct CardCreate {
    
    /// Create a card with default settings
    public static func execute(type: CardType) -> CardModel {
        CardModel(
            id: UUID(),
            type: type,
            alignment: .leading,
            layout: .vertical,
            state: .normal,
            elevation: .medium
        )
    }
    
    /// Create a card with custom configuration
    public static func execute(
        type: CardType,
        alignment: CardAlignment,
        layout: CardLayout,
        elevation: CardElevation
    ) -> CardModel {
        CardModel(
            id: UUID(),
            type: type,
            alignment: alignment,
            layout: layout,
            state: .normal,
            elevation: elevation
        )
    }
    
    /// Create a card from properties
    public static func execute(type: CardType, properties: [String: Any]) -> CardModel {
        let alignment = CardAlignment(rawValue: properties["alignment"] as? String ?? "leading") ?? .leading
        let layout = CardLayout(rawValue: properties["layout"] as? String ?? "vertical") ?? .vertical
        
        return CardModel(
            id: UUID(),
            type: type,
            alignment: alignment,
            layout: layout,
            state: .normal,
            elevation: .medium
        )
    }
}

/// Temporary CardModel struct
private struct CardModel {
    let id: UUID
    let type: CardType
    let alignment: CardAlignment
    let layout: CardLayout
    let state: CardState
    let elevation: CardElevation
}
