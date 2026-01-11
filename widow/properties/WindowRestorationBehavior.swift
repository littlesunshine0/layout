import Foundation

/// Controls if and how the window's state is saved and restored when the application is relaunched
enum WindowRestorationBehavior {
    case `default`       // Use the system's default behavior
    case none            // Don't save or restore
    case onLaunch        // Restore on app launch
    case onLaunchOver1   // Restore on launch if version > 1
    
    var description: String {
        switch self {
        case .default: return "Default"
        case .none: return "None"
        case .onLaunch: return "On Launch"
        case .onLaunchOver1: return "On Launch (Version > 1)"
        }
    }
}
