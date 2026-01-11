import Foundation

/// State attribute for panels
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public enum PanelState: String, CaseIterable, Hashable, Codable {
    case normal
    case focused
    case dragging
    case resizing
    case minimized
    case maximized
    case detached
    
    public var description: String {
        rawValue.capitalized
    }
    
    public var isInteractive: Bool {
        self != .minimized
    }
}
