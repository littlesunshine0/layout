import Foundation

/// The overall visual style of the window
enum WindowStyle {
    case `default`
    case plain           // Borderless
    case titleBarOnly    // Title bar without other chrome
    case hiddenTitleBar  // Title bar is hidden but still functional
    
    var description: String {
        switch self {
        case .default: return "Default"
        case .plain: return "Plain (Borderless)"
        case .titleBarOnly: return "Title Bar Only"
        case .hiddenTitleBar: return "Hidden Title Bar"
        }
    }
}
