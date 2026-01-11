import Foundation

/// Validate operation for cards
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct CardValidate {
    
    public struct ValidationResult {
        public let isValid: Bool
        public let errors: [String]
        public let warnings: [String]
        
        public init(isValid: Bool, errors: [String] = [], warnings: [String] = []) {
            self.isValid = isValid
            self.errors = errors
            self.warnings = warnings
        }
    }
    
    /// Validate a card configuration
    public static func execute(_ card: CardModel) -> ValidationResult {
        var errors: [String] = []
        var warnings: [String] = []
        
        // Validate state
        if card.state == .selected && !card.isSelectable {
            errors.append("Card is selected but not selectable")
        }
        
        if card.state == .hovered && !card.showsHover {
            warnings.append("Card is hovered but hover effects are disabled")
        }
        
        return ValidationResult(
            isValid: errors.isEmpty,
            errors: errors,
            warnings: warnings
        )
    }
}

/// Temporary CardModel struct
private struct CardModel {
    let state: CardState
    let isSelectable: Bool = false
    let showsHover: Bool = true
}
