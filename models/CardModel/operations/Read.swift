import Foundation

/// Read operation for cards
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct CardRead {
    
    /// Read a card by ID
    public static func execute(id: UUID) -> CardModel? {
        nil
    }
    
    /// Read all cards of a specific type
    public static func execute(type: CardType) -> [CardModel] {
        []
    }
    
    /// Read all cards
    public static func executeAll() -> [CardModel] {
        []
    }
    
    /// Read cards matching a predicate
    public static func execute(where predicate: (CardModel) -> Bool) -> [CardModel] {
        executeAll().filter(predicate)
    }
}

/// Temporary CardModel struct
private struct CardModel {
    let id: UUID
    let type: CardType
}
