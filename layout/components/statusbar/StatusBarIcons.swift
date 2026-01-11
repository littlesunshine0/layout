import Foundation

// MARK: - StatusBar Icons

@available(macOS 10.15, iOS 13.0, *)
struct StatusBarIcons {
    
    // System Icons
    static let clockIcon = "clock"
    static let wifiIcon = "wifi"
    static let batteryIcon = "battery.100"
    static let cpuIcon = "flame"
    static let memoryIcon = "memorychip"
    static let diskIcon = "internaldrive"
    
    // Status Icons
    static let successIcon = "checkmark.circle"
    static let errorIcon = "xmark.circle"
    static let warningIcon = "exclamationmark.triangle"
    static let infoIcon = "info.circle"
    
    // Connectivity Icons
    static let connectedIcon = "checkmark.circle.fill"
    static let disconnectedIcon = "xmark.circle.fill"
    static let syncIcon = "arrow.triangle.2.circlepath"
    
    // Document Icons
    static let linesIcon = "text.alignleft"
    static let wordsIcon = "text.word.spacing"
    static let charactersIcon = "character"
    
    // Progress Icons
    static let progressIcon = "circle.hexagongrid.circle"
    static let loadingIcon = "arrow.2.circlepath"
    
    static var allIcons: [String: String] {
        [
            "clock": clockIcon,
            "wifi": wifiIcon,
            "battery": batteryIcon,
            "cpu": cpuIcon,
            "memory": memoryIcon,
            "disk": diskIcon,
            "success": successIcon,
            "error": errorIcon,
            "warning": warningIcon,
            "info": infoIcon,
            "connected": connectedIcon,
            "disconnected": disconnectedIcon,
            "sync": syncIcon,
            "lines": linesIcon,
            "words": wordsIcon,
            "characters": charactersIcon,
            "progress": progressIcon,
            "loading": loadingIcon
        ]
    }
    
    static func getIcon(named name: String) -> String? {
        allIcons[name]
    }
}
