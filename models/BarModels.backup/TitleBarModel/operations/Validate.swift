import Foundation

/// Validate operation for TitleBar component
/// Handles validation of title bar configuration
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarValidate {
    
    public struct ValidationResult {
        public let isValid: Bool
        public let errors: [String]
        public let warnings: [String]
    }
    
    /// Validates a title bar model
    public static func execute(_ model: TitleBarModel) -> ValidationResult {
        var errors: [String] = []
        var warnings: [String] = []
        
        // Height validation
        if model.height < 24 {
            errors.append("Height must be at least 24 points")
        } else if model.height > 200 {
            warnings.append("Height is unusually large (\(model.height) points)")
        }
        
        // Title validation
        if !model.showsTitle && !model.showsIcon {
            warnings.append("Neither title nor icon is visible")
        }
        
        // Button validation
        if model.buttons.isEmpty {
            warnings.append("No buttons configured")
        }
        
        // Color validation
        if !isValidHexColor(model.backgroundColor) {
            errors.append("Invalid background color format")
        }
        
        return ValidationResult(
            isValid: errors.isEmpty,
            errors: errors,
            warnings: warnings
        )
    }
    
    private static func isValidHexColor(_ hex: String) -> Bool {
        let pattern = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$"
        return hex.range(of: pattern, options: .regularExpression) != nil
    }
}
