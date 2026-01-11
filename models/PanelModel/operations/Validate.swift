import Foundation

/// Validate operation for panels
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct PanelValidate {
    
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
    
    /// Validate a panel configuration
    public static func execute(_ panel: PanelModel) -> ValidationResult {
        var errors: [String] = []
        var warnings: [String] = []
        
        // Validate type-specific constraints
        if panel.state == .detached && !panel.type.supportsDetachment {
            errors.append("This panel type does not support detachment")
        }
        
        if panel.state == .resizing && !panel.type.canResize {
            errors.append("This panel type cannot be resized")
        }
        
        // Validate visibility
        if !panel.visibility.isVisible && panel.state == .focused {
            errors.append("Hidden panels cannot be focused")
        }
        
        if panel.visibility.isCollapsed && !panel.visibility.canCollapse {
            errors.append("Panel is collapsed but collapse is not enabled")
        }
        
        return ValidationResult(
            isValid: errors.isEmpty,
            errors: errors,
            warnings: warnings
        )
    }
}

/// Temporary PanelModel struct for reference
private struct PanelModel {
    let type: PanelType
    let visibility: PanelVisibility
    let state: PanelState
}
