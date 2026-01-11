import Foundation

/// State attribute for controls
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum ControlState: String, CaseIterable, Hashable, Codable {
    case normal
    case hovered
    case pressed
    case selected
    case disabled
    case focused
    case loading
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var isInteractive: Bool {
        self != .disabled && self != .loading
    }
}
