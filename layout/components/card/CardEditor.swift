import Foundation

// MARK: - Card Editor

@available(macOS 10.15, iOS 13.0, *)
struct CardEditor {
    
    // MARK: - Edit Operations
    
    /// Edit card properties
    static func edit(_ card: inout CardModel.Card, changes: [EditField: String]) {
        for (field, value) in changes {
            switch field {
            case .title:
                card.title = value
            case .subtitle:
                card.subtitle = value.isEmpty ? nil : value
            case .description:
                card.description = value.isEmpty ? nil : value
            case .imageName:
                card.imageName = value.isEmpty ? nil : value
            case .imageURL:
                card.imageURL = value.isEmpty ? nil : value
            case .badge:
                card.badge = value.isEmpty ? nil : value
            }
            card.updatedAt = Date()
        }
    }
    
    /// Batch edit multiple cards
    static func batchEdit(_ cards: inout [CardModel.Card], changes: [EditField: String]) {
        for index in cards.indices {
            edit(&cards[index], changes: changes)
        }
    }
    
    /// Edit specific field
    static func editField(_ card: inout CardModel.Card, field: EditField, value: String) {
        edit(&card, changes: [field: value])
    }
    
    // MARK: - Validation
    
    /// Validate card data
    static func validate(_ card: CardModel.Card) -> ValidationResult {
        var errors: [String] = []
        var warnings: [String] = []
        
        // Title validation
        if card.title.isEmpty {
            errors.append("Title cannot be empty")
        }
        
        if card.title.count > 100 {
            warnings.append("Title is too long (\(card.title.count) characters)")
        }
        
        // Subtitle validation
        if let subtitle = card.subtitle, subtitle.count > 200 {
            warnings.append("Subtitle is too long (\(subtitle.count) characters)")
        }
        
        // Description validation
        if let description = card.description, description.count > 1000 {
            warnings.append("Description is too long (\(description.count) characters)")
        }
        
        // Image validation
        if card.imageName == nil && card.imageURL == nil {
            warnings.append("No image specified")
        }
        
        // URL validation
        if let urlString = card.imageURL, URL(string: urlString) == nil {
            errors.append("Invalid image URL")
        }
        
        // Tags validation
        if card.tags.isEmpty {
            warnings.append("No tags specified")
        }
        
        return ValidationResult(
            isValid: errors.isEmpty,
            errors: errors,
            warnings: warnings
        )
    }
    
    /// Validate multiple cards
    static func validateAll(_ cards: [CardModel.Card]) -> [String: ValidationResult] {
        var results: [String: ValidationResult] = [:]
        for card in cards {
            results[card.id] = validate(card)
        }
        return results
    }
    
    // MARK: - Transform Operations
    
    /// Transform card data
    static func transform(_ card: inout CardModel.Card, transformation: Transformation) {
        switch transformation {
        case .uppercase:
            card.title = card.title.uppercased()
            card.subtitle = card.subtitle?.uppercased()
        case .lowercase:
            card.title = card.title.lowercased()
            card.subtitle = card.subtitle?.lowercased()
        case .capitalize:
            card.title = card.title.capitalized
            card.subtitle = card.subtitle?.capitalized
        case .trim:
            card.title = card.title.trimmingCharacters(in: .whitespacesAndNewlines)
            card.subtitle = card.subtitle?.trimmingCharacters(in: .whitespacesAndNewlines)
            card.description = card.description?.trimmingCharacters(in: .whitespacesAndNewlines)
        case .removeSpecialChars:
            card.title = card.title.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
        case .truncate(let length):
            if card.title.count > length {
                card.title = String(card.title.prefix(length)) + "..."
            }
        }
        card.updatedAt = Date()
    }
    
    /// Batch transform
    static func batchTransform(_ cards: inout [CardModel.Card], transformation: Transformation) {
        for index in cards.indices {
            transform(&cards[index], transformation: transformation)
        }
    }
    
    // MARK: - Metadata Operations
    
    /// Add metadata
    static func addMetadata(_ card: inout CardModel.Card, key: String, value: String) {
        card.metadata[key] = value
        card.updatedAt = Date()
    }
    
    /// Remove metadata
    static func removeMetadata(_ card: inout CardModel.Card, key: String) {
        card.metadata.removeValue(forKey: key)
        card.updatedAt = Date()
    }
    
    /// Update all metadata
    static func updateMetadata(_ card: inout CardModel.Card, metadata: [String: String]) {
        card.metadata = metadata
        card.updatedAt = Date()
    }
    
    // MARK: - Tag Operations
    
    /// Add tags
    static func addTags(_ card: inout CardModel.Card, tags: [String]) {
        for tag in tags where !card.tags.contains(tag) {
            card.tags.append(tag)
        }
        card.updatedAt = Date()
    }
    
    /// Remove tags
    static func removeTags(_ card: inout CardModel.Card, tags: [String]) {
        card.tags.removeAll { tags.contains($0) }
        card.updatedAt = Date()
    }
    
    /// Replace tags
    static func replaceTags(_ card: inout CardModel.Card, tags: [String]) {
        card.tags = tags
        card.updatedAt = Date()
    }
    
    // MARK: - Merge Operations
    
    /// Merge two cards
    static func merge(_ card1: CardModel.Card, with card2: CardModel.Card, strategy: MergeStrategy) -> CardModel.Card {
        var merged = card1
        
        switch strategy {
        case .preferFirst:
            // Keep card1 values, only fill in missing
            merged.subtitle = merged.subtitle ?? card2.subtitle
            merged.description = merged.description ?? card2.description
            merged.imageName = merged.imageName ?? card2.imageName
        case .preferSecond:
            // Override with card2 values
            merged.subtitle = card2.subtitle ?? merged.subtitle
            merged.description = card2.description ?? merged.description
            merged.imageName = card2.imageName ?? merged.imageName
        case .combine:
            // Combine data
            if let desc1 = merged.description, let desc2 = card2.description {
                merged.description = "\(desc1)\n\n\(desc2)"
            } else {
                merged.description = merged.description ?? card2.description
            }
            merged.tags = Array(Set(merged.tags + card2.tags))
            merged.metadata.merge(card2.metadata) { $1 }
        }
        
        merged.updatedAt = Date()
        return merged
    }
    
    // MARK: - Supporting Types
    
    enum EditField {
        case title
        case subtitle
        case description
        case imageName
        case imageURL
        case badge
    }
    
    struct ValidationResult {
        let isValid: Bool
        let errors: [String]
        let warnings: [String]
        
        var hasWarnings: Bool { !warnings.isEmpty }
        var message: String {
            var msg = ""
            if !errors.isEmpty {
                msg += "Errors:\n" + errors.joined(separator: "\n")
            }
            if !warnings.isEmpty {
                if !msg.isEmpty { msg += "\n\n" }
                msg += "Warnings:\n" + warnings.joined(separator: "\n")
            }
            return msg
        }
    }
    
    enum Transformation {
        case uppercase
        case lowercase
        case capitalize
        case trim
        case removeSpecialChars
        case truncate(length: Int)
    }
    
    enum MergeStrategy {
        case preferFirst
        case preferSecond
        case combine
    }
}
