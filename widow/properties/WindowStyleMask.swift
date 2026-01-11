import Foundation

/// A set of flags that define the window's appearance and behavior
struct WindowStyleMask: OptionSet {
    let rawValue: Int
    
    static let borderless = WindowStyleMask(rawValue: 1 << 0)
    static let titled = WindowStyleMask(rawValue: 1 << 1)
    static let closable = WindowStyleMask(rawValue: 1 << 2)
    static let miniaturizable = WindowStyleMask(rawValue: 1 << 3)
    static let resizable = WindowStyleMask(rawValue: 1 << 4)
    static let utilityWindow = WindowStyleMask(rawValue: 1 << 5)
    static let docModalWindow = WindowStyleMask(rawValue: 1 << 6)
    static let nonactivatingPanel = WindowStyleMask(rawValue: 1 << 7)
    static let hudWindow = WindowStyleMask(rawValue: 1 << 8)
    static let fullScreen = WindowStyleMask(rawValue: 1 << 9)
    static let fullSizeContentView = WindowStyleMask(rawValue: 1 << 10)
    
    static let `default`: WindowStyleMask = [.titled, .closable, .miniaturizable, .resizable]
}
