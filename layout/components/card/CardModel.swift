import Foundation
import Combine

// MARK: - Card Model

struct CardModel {
    // Layout Properties
    var width: Double
    var height: Double
    var padding: Double
    var cornerRadius: Double
    var spacing: Double
    var layout: CardLayout
    
    // Visual Properties
    var backgroundColor: String
    var borderWidth: Double
    var borderColor: String
    
    // Shadow Properties
    var shadowEnabled: Bool
    var shadowColor: String
    var shadowRadius: Double
    var shadowOpacity: Double
    
    // Content Properties
    var imageHeight: Double
    var titleFont: String
    var subtitleFont: String
    
    // Interaction Properties
    var hoverEnabled: Bool
    var hoverScale: Double
    var selectable: Bool
    var actionButtons: [CardAction]
    
    // MARK: - Enums
    
    enum CardLayout: String, CaseIterable {
        case vertical
        case horizontal
        case grid
        case list
        
        var description: String {
            switch self {
            case .vertical: return "Vertical"
            case .horizontal: return "Horizontal"
            case .grid: return "Grid"
            case .list: return "List"
            }
        }
    }
    
    enum CardAction: String, CaseIterable {
        case edit
        case delete
        case share
        case duplicate
        case archive
        case favorite
        case open
        case download
        
        var icon: String {
            switch self {
            case .edit: return "pencil"
            case .delete: return "trash"
            case .share: return "square.and.arrow.up"
            case .duplicate: return "doc.on.doc"
            case .archive: return "archivebox"
            case .favorite: return "star"
            case .open: return "arrow.up.right.square"
            case .download: return "arrow.down.circle"
            }
        }
    }
    
    // MARK: - Card Data
    
    struct Card: Identifiable {
        let id: String
        var title: String
        var subtitle: String?
        var description: String?
        var imageName: String?
        var imageURL: String?
        var badge: String?
        var metadata: [String: String]
        var isFavorite: Bool
        var isArchived: Bool
        var createdAt: Date
        var updatedAt: Date
        var tags: [String]
        
        init(
            id: String = UUID().uuidString,
            title: String,
            subtitle: String? = nil,
            description: String? = nil,
            imageName: String? = nil,
            imageURL: String? = nil,
            badge: String? = nil,
            metadata: [String: String] = [:],
            isFavorite: Bool = false,
            isArchived: Bool = false,
            createdAt: Date = Date(),
            updatedAt: Date = Date(),
            tags: [String] = []
        ) {
            self.id = id
            self.title = title
            self.subtitle = subtitle
            self.description = description
            self.imageName = imageName
            self.imageURL = imageURL
            self.badge = badge
            self.metadata = metadata
            self.isFavorite = isFavorite
            self.isArchived = isArchived
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.tags = tags
        }
    }
    
    // MARK: - Mock Data
    
    static func mock() -> CardModel {
        CardModel(
            width: 280,
            height: 320,
            padding: 16,
            cornerRadius: 12,
            spacing: 12,
            layout: .vertical,
            backgroundColor: "#1C1C1E",
            borderWidth: 1,
            borderColor: "#2C2C2E",
            shadowEnabled: true,
            shadowColor: "#000000",
            shadowRadius: 8,
            shadowOpacity: 0.3,
            imageHeight: 160,
            titleFont: "headline",
            subtitleFont: "subheadline",
            hoverEnabled: true,
            hoverScale: 1.05,
            selectable: true,
            actionButtons: [.edit, .delete, .share]
        )
    }
    
    static func mockCards() -> [Card] {
        [
            Card(
                title: "FlowKit Project",
                subtitle: "37 Kits",
                description: "Comprehensive Swift package collection",
                imageName: "flowkit-icon",
                badge: "Active",
                metadata: ["kits": "37", "status": "active"],
                isFavorite: true,
                tags: ["swift", "package", "framework"]
            ),
            Card(
                title: "Layout System",
                subtitle: "UI Blueprint",
                description: "Property-based UI component system",
                imageName: "layout-icon",
                badge: "In Progress",
                metadata: ["components": "10", "status": "development"],
                tags: ["ui", "design", "components"]
            ),
            Card(
                title: "Project Creator",
                subtitle: "AI-Powered",
                description: "Natural language project generation",
                imageName: "creator-icon",
                metadata: ["created": "15", "status": "beta"],
                isFavorite: true,
                tags: ["ai", "automation", "tools"]
            )
        ]
    }
    
    // MARK: - Load from Properties
    
    static func fromProperties() -> CardModel {
        let loader = PropertyLoader.shared
        
        return CardModel(
            width: loader.loadDouble(component: "card", property: "CardWidth", defaultValue: 280),
            height: loader.loadDouble(component: "card", property: "CardHeight", defaultValue: 320),
            padding: loader.loadDouble(component: "card", property: "CardPadding", defaultValue: 16),
            cornerRadius: loader.loadDouble(component: "card", property: "CardCornerRadius", defaultValue: 12),
            spacing: loader.loadDouble(component: "card", property: "CardSpacing", defaultValue: 12),
            layout: CardLayout(rawValue: loader.loadString(component: "card", property: "CardLayout", defaultValue: "vertical")) ?? .vertical,
            backgroundColor: loader.loadString(component: "card", property: "CardBackgroundColor", defaultValue: "#1C1C1E"),
            borderWidth: loader.loadDouble(component: "card", property: "CardBorderWidth", defaultValue: 1),
            borderColor: loader.loadString(component: "card", property: "CardBorderColor", defaultValue: "#2C2C2E"),
            shadowEnabled: loader.loadBool(component: "card", property: "CardShadowEnabled", defaultValue: true),
            shadowColor: loader.loadString(component: "card", property: "CardShadowColor", defaultValue: "#000000"),
            shadowRadius: loader.loadDouble(component: "card", property: "CardShadowRadius", defaultValue: 8),
            shadowOpacity: loader.loadDouble(component: "card", property: "CardShadowOpacity", defaultValue: 0.3),
            imageHeight: loader.loadDouble(component: "card", property: "CardImageHeight", defaultValue: 160),
            titleFont: loader.loadString(component: "card", property: "CardTitleFont", defaultValue: "headline"),
            subtitleFont: loader.loadString(component: "card", property: "CardSubtitleFont", defaultValue: "subheadline"),
            hoverEnabled: loader.loadBool(component: "card", property: "CardHoverEnabled", defaultValue: true),
            hoverScale: loader.loadDouble(component: "card", property: "CardHoverScale", defaultValue: 1.05),
            selectable: loader.loadBool(component: "card", property: "CardSelectable", defaultValue: true),
            actionButtons: loader.loadArray(component: "card", property: "CardActionButtons", defaultValue: ["edit", "delete", "share"])
                .compactMap { CardAction(rawValue: $0) }
        )
    }
}
