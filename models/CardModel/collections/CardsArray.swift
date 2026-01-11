import Foundation

/// Collection of cards array
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct CardsArray: Hashable, Codable {
    private var cards: [UUID]
    
    public init(_ cards: [UUID] = []) {
        self.cards = cards
    }
    
    public mutating func add(_ cardId: UUID) {
        cards.append(cardId)
    }
    
    public mutating func remove(_ cardId: UUID) {
        cards.removeAll { $0 == cardId }
    }
    
    public func contains(_ cardId: UUID) -> Bool {
        cards.contains(cardId)
    }
    
    public var count: Int {
        cards.count
    }
    
    public subscript(index: Int) -> UUID {
        cards[index]
    }
}
