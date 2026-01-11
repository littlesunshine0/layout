import Foundation

/// Position attribute for bars
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum BarPosition: String, CaseIterable, Hashable, Codable {
    case top
    case bottom
    case floating
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var isFixed: Bool {
        self != .floating
    }
}
