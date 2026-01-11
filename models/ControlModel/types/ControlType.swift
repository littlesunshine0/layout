import Foundation

/// Control type definition
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum ControlType: String, CaseIterable, Hashable, Codable {
    case button
    case chip
    case accordion
    case segmented
    case stepper
    case toggle
    case slider
    case checkbox
    case radio
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var defaultHeight: CGFloat {
        switch self {
        case .button: return 44.0
        case .chip: return 32.0
        case .accordion: return 48.0
        case .segmented: return 32.0
        case .stepper: return 32.0
        case .toggle: return 31.0
        case .slider: return 44.0
        case .checkbox: return 24.0
        case .radio: return 24.0
        }
    }
    
    public var supportsMultipleStates: Bool {
        switch self {
        case .accordion, .toggle, .checkbox:
            return true
        default:
            return false
        }
    }
}
