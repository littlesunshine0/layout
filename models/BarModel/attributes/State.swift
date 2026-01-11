import Foundation

/// State attribute for bars
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum BarState: String, CaseIterable, Hashable, Codable {
    case normal
    case focused
    case inactive
    case disabled
    case fullscreen
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var isInteractive: Bool {
        self != .disabled
    }
}
