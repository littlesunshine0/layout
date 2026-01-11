import Foundation

/// Defines how the window interacts with system features like Mission Control, Spaces, and Stage Manager
struct WindowCollectionBehavior: OptionSet {
    let rawValue: Int
    
    static let canJoinAllSpaces = WindowCollectionBehavior(rawValue: 1 << 0)
    static let moveToActiveSpace = WindowCollectionBehavior(rawValue: 1 << 1)
    static let managed = WindowCollectionBehavior(rawValue: 1 << 2)
    static let transient = WindowCollectionBehavior(rawValue: 1 << 3)
    static let stationary = WindowCollectionBehavior(rawValue: 1 << 4)
    static let participatesInCycle = WindowCollectionBehavior(rawValue: 1 << 5)
    static let ignoresCycle = WindowCollectionBehavior(rawValue: 1 << 6)
    static let fullScreenPrimary = WindowCollectionBehavior(rawValue: 1 << 7)
    static let fullScreenAuxiliary = WindowCollectionBehavior(rawValue: 1 << 8)
    
    static let `default`: WindowCollectionBehavior = [.managed, .participatesInCycle]
}
