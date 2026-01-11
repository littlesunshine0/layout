import Foundation

/// Title bar validation operation
/// Handles validation of title bar configuration and state
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarValidateOperation {
    
    /// Validates title bar configuration
    public static func validate(_ config: TitleBarConfiguration) -> ValidationResult {
        var errors: [ValidationError] = []
        
        // Validate height
        if config.height < 22.0 || config.height > 100.0 {
            errors.append(.invalidHeight(config.height))
        }
        
        // Validate title
        if config.title.isEmpty {
            errors.append(.emptyTitle)
        }
        
        if config.title.count > 255 {
            errors.append(.titleTooLong(config.title.count))
        }
        
        return errors.isEmpty ? .valid : .invalid(errors)
    }
    
    /// Validates title bar instance
    public static func validateInstance(id: UUID) -> ValidationResult {
        guard let instance = TitleBarRegistry.shared.getInstance(id: id) else {
            return .invalid([.instanceNotFound])
        }
        
        return validate(instance.configuration)
    }
    
    /// Validates title bar state transition
    public static func validateStateTransition(from: TitleBarState, to: TitleBarState) -> Bool {
        // Define valid state transitions
        switch (from, to) {
        case (.active, .inactive), (.inactive, .active):
            return true
        case (.active, .hidden), (.inactive, .hidden):
            return true
        case (.hidden, .active), (.hidden, .inactive):
            return true
        case (.expanded, .collapsed), (.collapsed, .expanded):
            return true
        default:
            return from == to
        }
    }
}

/// Validation result enumeration
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum ValidationResult {
    case valid
    case invalid([ValidationError])
    
    public var isValid: Bool {
        if case .valid = self {
            return true
        }
        return false
    }
}

/// Validation error types
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum ValidationError: Error {
    case invalidHeight(CGFloat)
    case emptyTitle
    case titleTooLong(Int)
    case instanceNotFound
    case invalidStateTransition
}
