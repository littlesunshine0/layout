import Foundation

/// Title bar state type definition
/// Comprehensive state management for title bar
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarStateType {
    public var current: State
    public var previous: State?
    public var timestamp: Date
    
    public enum State: String, Codable {
        case active
        case inactive
        case disabled
        case hidden
        case collapsed
        case expanded
        case transitioning
    }
    
    public init(current: State) {
        self.current = current
        self.previous = nil
        self.timestamp = Date()
    }
    
    public mutating func transition(to newState: State) {
        self.previous = self.current
        self.current = newState
        self.timestamp = Date()
    }
}

/// Title bar lifecycle state
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarLifecycleState {
    case uninitialized
    case initializing
    case ready
    case active
    case suspended
    case terminating
    case terminated
    
    public var canTransition: Bool {
        switch self {
        case .uninitialized, .initializing, .ready, .active, .suspended:
            return true
        case .terminating, .terminated:
            return false
        }
    }
}
