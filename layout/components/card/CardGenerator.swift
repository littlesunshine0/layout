import Foundation

// MARK: - Card Generator

@available(macOS 10.15, iOS 13.0, *)
struct CardGenerator {
    
    // MARK: - Template Types
    
    enum CardTemplate {
        case project
        case package
        case file
        case gallery
        case contact
        case product
        case article
        case event
        case custom
        
        var defaultProperties: (title: String, subtitle: String?, icon: String) {
            switch self {
            case .project:
                return ("New Project", "0 files", "folder")
            case .package:
                return ("New Package", "Swift Package", "shippingbox")
            case .file:
                return ("New File", "Document", "doc")
            case .gallery:
                return ("New Image", "Photo", "photo")
            case .contact:
                return ("New Contact", nil, "person.circle")
            case .product:
                return ("New Product", "$0.00", "cart")
            case .article:
                return ("New Article", "Draft", "doc.text")
            case .event:
                return ("New Event", "Today", "calendar")
            case .custom:
                return ("New Card", nil, "square.fill")
            }
        }
    }
    
    // MARK: - Generation Methods
    
    /// Generate a single card from template
    static func generateCard(from template: CardTemplate, customData: [String: String] = [:]) -> CardModel.Card {
        let props = template.defaultProperties
        
        return CardModel.Card(
            title: customData["title"] ?? props.title,
            subtitle: customData["subtitle"] ?? props.subtitle,
            description: customData["description"],
            imageName: customData["imageName"] ?? props.icon,
            imageURL: customData["imageURL"],
            badge: customData["badge"],
            metadata: customData,
            tags: customData["tags"]?.components(separatedBy: ",") ?? []
        )
    }
    
    /// Generate multiple cards from template
    static func generateCards(count: Int, from template: CardTemplate) -> [CardModel.Card] {
        (1...count).map { index in
            let props = template.defaultProperties
            return CardModel.Card(
                title: "\(props.title) \(index)",
                subtitle: props.subtitle,
                imageName: props.icon,
                tags: [template.rawValue]
            )
        }
    }
    
    /// Generate cards from JSON
    static func generateCards(from json: Data) -> [CardModel.Card]? {
        try? JSONDecoder().decode([CardModel.Card].self, from: json)
    }
    
    /// Generate card from dictionary
    static func generateCard(from dict: [String: Any]) -> CardModel.Card? {
        guard let title = dict["title"] as? String else { return nil }
        
        return CardModel.Card(
            title: title,
            subtitle: dict["subtitle"] as? String,
            description: dict["description"] as? String,
            imageName: dict["imageName"] as? String,
            imageURL: dict["imageURL"] as? String,
            badge: dict["badge"] as? String,
            metadata: dict["metadata"] as? [String: String] ?? [:],
            isFavorite: dict["isFavorite"] as? Bool ?? false,
            isArchived: dict["isArchived"] as? Bool ?? false,
            tags: dict["tags"] as? [String] ?? []
        )
    }
    
    /// Generate cards from CSV
    static func generateCards(from csv: String) -> [CardModel.Card] {
        let rows = csv.components(separatedBy: "\n")
        guard rows.count > 1 else { return [] }
        
        let headers = rows[0].components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        return rows.dropFirst().compactMap { row in
            let values = row.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            guard values.count == headers.count else { return nil }
            
            var dict: [String: String] = [:]
            for (header, value) in zip(headers, values) {
                dict[header] = value
            }
            
            return CardModel.Card(
                title: dict["title"] ?? "Untitled",
                subtitle: dict["subtitle"],
                description: dict["description"],
                imageName: dict["imageName"],
                imageURL: dict["imageURL"],
                badge: dict["badge"],
                tags: dict["tags"]?.components(separatedBy: "|") ?? []
            )
        }
    }
    
    // MARK: - Export Methods
    
    /// Export cards to JSON
    static func exportToJSON(_ cards: [CardModel.Card]) -> Data? {
        try? JSONEncoder().encode(cards)
    }
    
    /// Export cards to CSV
    static func exportToCSV(_ cards: [CardModel.Card]) -> String {
        var csv = "title,subtitle,description,imageName,badge,tags\n"
        
        for card in cards {
            let row = [
                card.title,
                card.subtitle ?? "",
                card.description ?? "",
                card.imageName ?? "",
                card.badge ?? "",
                card.tags.joined(separator: "|")
            ].joined(separator: ",")
            
            csv += row + "\n"
        }
        
        return csv
    }
    
    /// Export card to property files
    static func exportToProperties(_ card: CardModel.Card, basePath: String) throws {
        let properties: [(String, String)] = [
            ("CardTitle", card.title),
            ("CardSubtitle", card.subtitle ?? ""),
            ("CardDescription", card.description ?? ""),
            ("CardImageName", card.imageName ?? ""),
            ("CardBadge", card.badge ?? ""),
            ("CardTags", card.tags.joined(separator: ","))
        ]
        
        for (key, value) in properties {
            let path = "\(basePath)/\(key)"
            try value.write(toFile: path, atomically: true, encoding: .utf8)
        }
    }
    
    // MARK: - Batch Generation
    
    /// Generate cards for FlowKit packages
    static func generateFlowKitCards(packages: [String]) -> [CardModel.Card] {
        packages.map { package in
            CardModel.Card(
                title: package,
                subtitle: "Swift Package",
                description: "FlowKit package component",
                imageName: "shippingbox",
                badge: "FlowKit",
                tags: ["flowkit", "package", "swift"]
            )
        }
    }
    
    /// Generate cards for projects
    static func generateProjectCards(projects: [String]) -> [CardModel.Card] {
        projects.map { project in
            CardModel.Card(
                title: project,
                subtitle: "Project",
                description: "Swift project directory",
                imageName: "folder",
                badge: "Active",
                tags: ["project", "swift"]
            )
        }
    }
}

// MARK: - Card Template Extension

@available(macOS 10.15, iOS 13.0, *)
extension CardGenerator.CardTemplate: CaseIterable, RawRepresentable {
    typealias RawValue = String
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "project": self = .project
        case "package": self = .package
        case "file": self = .file
        case "gallery": self = .gallery
        case "contact": self = .contact
        case "product": self = .product
        case "article": self = .article
        case "event": self = .event
        case "custom": self = .custom
        default: return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .project: return "project"
        case .package: return "package"
        case .file: return "file"
        case .gallery: return "gallery"
        case .contact: return "contact"
        case .product: return "product"
        case .article: return "article"
        case .event: return "event"
        case .custom: return "custom"
        }
    }
}
