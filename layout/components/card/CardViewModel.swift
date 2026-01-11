import Foundation
import Combine

// MARK: - Card ViewModel

@available(macOS 10.15, iOS 13.0, *)
final class CardViewModel: ObservableObject {
    // Published Properties
    @Published var model: CardModel
    @Published var cards: [CardModel.Card]
    @Published var selectedCard: CardModel.Card?
    @Published var hoveredCard: String?
    @Published var searchQuery: String = ""
    @Published var filterTags: Set<String> = []
    @Published var sortOrder: SortOrder = .dateDescending
    @Published var showArchived: Bool = false
    
    // Private
    private var dataSource: CardDataSource?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Enums
    
    enum SortOrder {
        case titleAscending
        case titleDescending
        case dateAscending
        case dateDescending
        case favoriteFirst
    }
    
    // MARK: - Initialization
    
    init(model: CardModel = .mock(), cards: [CardModel.Card] = CardModel.mockCards()) {
        self.model = model
        self.cards = cards
    }
    
    // MARK: - CRUD Operations
    
    // Create
    func createCard(
        title: String,
        subtitle: String? = nil,
        description: String? = nil,
        imageName: String? = nil,
        imageURL: String? = nil,
        tags: [String] = []
    ) {
        let card = CardModel.Card(
            title: title,
            subtitle: subtitle,
            description: description,
            imageName: imageName,
            imageURL: imageURL,
            tags: tags
        )
        
        if let dataSource = dataSource {
            dataSource.createCard(card)
        } else {
            cards.append(card)
        }
    }
    
    // Read
    func getCard(byId id: String) -> CardModel.Card? {
        cards.first { $0.id == id }
    }
    
    func filteredCards() -> [CardModel.Card] {
        var filtered = cards
        
        // Filter by search query
        if !searchQuery.isEmpty {
            filtered = filtered.filter { card in
                card.title.localizedCaseInsensitiveContains(searchQuery) ||
                card.subtitle?.localizedCaseInsensitiveContains(searchQuery) == true ||
                card.description?.localizedCaseInsensitiveContains(searchQuery) == true
            }
        }
        
        // Filter by tags
        if !filterTags.isEmpty {
            filtered = filtered.filter { card in
                !Set(card.tags).isDisjoint(with: filterTags)
            }
        }
        
        // Filter archived
        if !showArchived {
            filtered = filtered.filter { !$0.isArchived }
        }
        
        // Sort
        return sortCards(filtered)
    }
    
    // Update
    func updateCard(_ card: CardModel.Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            var updated = card
            updated.updatedAt = Date()
            
            if let dataSource = dataSource {
                dataSource.updateCard(updated)
            } else {
                cards[index] = updated
            }
        }
    }
    
    func updateCardTitle(_ cardId: String, title: String) {
        if var card = getCard(byId: cardId) {
            card.title = title
            updateCard(card)
        }
    }
    
    func toggleFavorite(_ cardId: String) {
        if var card = getCard(byId: cardId) {
            card.isFavorite.toggle()
            updateCard(card)
        }
    }
    
    func archiveCard(_ cardId: String) {
        if var card = getCard(byId: cardId) {
            card.isArchived = true
            updateCard(card)
        }
    }
    
    func unarchiveCard(_ cardId: String) {
        if var card = getCard(byId: cardId) {
            card.isArchived = false
            updateCard(card)
        }
    }
    
    func addTag(_ cardId: String, tag: String) {
        if var card = getCard(byId: cardId) {
            if !card.tags.contains(tag) {
                card.tags.append(tag)
                updateCard(card)
            }
        }
    }
    
    func removeTag(_ cardId: String, tag: String) {
        if var card = getCard(byId: cardId) {
            card.tags.removeAll { $0 == tag }
            updateCard(card)
        }
    }
    
    // Delete
    func deleteCard(_ cardId: String) {
        if let dataSource = dataSource {
            dataSource.deleteCard(cardId)
        } else {
            cards.removeAll { $0.id == cardId }
        }
        
        if selectedCard?.id == cardId {
            selectedCard = nil
        }
    }
    
    func deleteMultiple(_ cardIds: [String]) {
        cardIds.forEach { deleteCard($0) }
    }
    
    // MARK: - Actions
    
    func handleAction(_ action: CardModel.CardAction, for cardId: String) {
        switch action {
        case .edit:
            selectCard(cardId)
        case .delete:
            deleteCard(cardId)
        case .share:
            shareCard(cardId)
        case .duplicate:
            duplicateCard(cardId)
        case .archive:
            archiveCard(cardId)
        case .favorite:
            toggleFavorite(cardId)
        case .open:
            openCard(cardId)
        case .download:
            downloadCard(cardId)
        }
    }
    
    func selectCard(_ cardId: String) {
        selectedCard = getCard(byId: cardId)
    }
    
    func setHoveredCard(_ cardId: String?) {
        hoveredCard = cardId
    }
    
    func duplicateCard(_ cardId: String) {
        if let card = getCard(byId: cardId) {
            createCard(
                title: "\(card.title) (Copy)",
                subtitle: card.subtitle,
                description: card.description,
                imageName: card.imageName,
                imageURL: card.imageURL,
                tags: card.tags
            )
        }
    }
    
    func shareCard(_ cardId: String) {
        // Implement share logic
        print("Sharing card: \(cardId)")
    }
    
    func openCard(_ cardId: String) {
        // Implement open logic
        print("Opening card: \(cardId)")
    }
    
    func downloadCard(_ cardId: String) {
        // Implement download logic
        print("Downloading card: \(cardId)")
    }
    
    // MARK: - Sorting
    
    private func sortCards(_ cards: [CardModel.Card]) -> [CardModel.Card] {
        switch sortOrder {
        case .titleAscending:
            return cards.sorted { $0.title < $1.title }
        case .titleDescending:
            return cards.sorted { $0.title > $1.title }
        case .dateAscending:
            return cards.sorted { $0.createdAt < $1.createdAt }
        case .dateDescending:
            return cards.sorted { $0.createdAt > $1.createdAt }
        case .favoriteFirst:
            return cards.sorted { $0.isFavorite && !$1.isFavorite }
        }
    }
    
    // MARK: - Bulk Operations
    
    func deleteArchived() {
        let archivedIds = cards.filter { $0.isArchived }.map { $0.id }
        deleteMultiple(archivedIds)
    }
    
    func exportCards() -> Data? {
        try? JSONEncoder().encode(cards)
    }
    
    func importCards(from data: Data) {
        if let imported = try? JSONDecoder().decode([CardModel.Card].self, from: data) {
            cards.append(contentsOf: imported)
        }
    }
    
    // MARK: - Statistics
    
    var totalCards: Int { cards.count }
    var favoriteCards: Int { cards.filter { $0.isFavorite }.count }
    var archivedCards: Int { cards.filter { $0.isArchived }.count }
    var allTags: [String] { Array(Set(cards.flatMap { $0.tags })).sorted() }
    
    // MARK: - Real Data Integration
    
    func connectToRealData(_ source: CardDataSource) {
        self.dataSource = source
        
        // Subscribe to card updates
        source.cardsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cards in
                self?.cards = cards
            }
            .store(in: &cancellables)
    }
}

// MARK: - Data Source Protocol

@available(macOS 10.15, iOS 13.0, *)
protocol CardDataSource {
    var cardsPublisher: AnyPublisher<[CardModel.Card], Never> { get }
    
    func createCard(_ card: CardModel.Card)
    func updateCard(_ card: CardModel.Card)
    func deleteCard(_ cardId: String)
}
