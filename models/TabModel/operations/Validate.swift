import Foundation

/// Validate operation for tabs
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TabValidate {
    
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
    
    /// Validate a tab configuration
    public static func execute(_ tab: TabModel) -> ValidationResult {
        var errors: [String] = []
        var warnings: [String] = []
        
        // Validate selection
        if tab.selection.selectedIndex < 0 {
            errors.append("Selected index cannot be negative")
        }
        
        if tab.state == .selected && !tab.isSelectable {
            errors.append("Tab is selected but not selectable")
        }
        
        return ValidationResult(
            isValid: errors.isEmpty,
            errors: errors,
            warnings: warnings
        )
    }
}

/// Temporary TabModel struct
private struct TabModel {
    let selection: TabSelection
    let state: TabState
    let isSelectable: Bool = true
}
