import Foundation

// MARK: - Card Icons

struct CardIcons {
    
    // MARK: - System Icons (SF Symbols)
    
    static let systemIcons: [String: String] = [
        // General
        "default": "square.fill",
        "placeholder": "photo",
        
        // Projects & Files
        "project": "folder",
        "package": "shippingbox",
        "file": "doc",
        "folder": "folder.fill",
        "code": "chevron.left.forwardslash.chevron.right",
        
        // Media
        "image": "photo",
        "video": "video",
        "audio": "music.note",
        "document": "doc.text",
        
        // People & Social
        "person": "person.circle",
        "group": "person.3",
        "contact": "person.crop.circle",
        
        // Commerce
        "product": "cart",
        "purchase": "creditcard",
        "gift": "gift",
        
        // Communication
        "message": "message",
        "email": "envelope",
        "notification": "bell",
        
        // Organization
        "calendar": "calendar",
        "event": "calendar.badge.clock",
        "bookmark": "bookmark",
        "tag": "tag",
        
        // Development
        "flowkit": "shippingbox.fill",
        "swift": "swift",
        "git": "arrow.triangle.branch",
        "terminal": "terminal",
        
        // Status
        "active": "checkmark.circle.fill",
        "inactive": "circle",
        "warning": "exclamationmark.triangle",
        "error": "xmark.circle",
        "success": "checkmark.circle",
        
        // Actions
        "edit": "pencil",
        "delete": "trash",
        "share": "square.and.arrow.up",
        "duplicate": "doc.on.doc",
        "archive": "archivebox",
        "favorite": "star",
        "download": "arrow.down.circle"
    ]
    
    // MARK: - Icon Categories
    
    enum Category: String, CaseIterable {
        case general
        case projects
        case media
        case people
        case commerce
        case communication
        case organization
        case development
        case status
        case actions
        
        var icons: [String] {
            switch self {
            case .general:
                return ["square.fill", "photo", "circle.fill"]
            case .projects:
                return ["folder", "shippingbox", "doc", "folder.fill"]
            case .media:
                return ["photo", "video", "music.note", "doc.text"]
            case .people:
                return ["person.circle", "person.3", "person.crop.circle"]
            case .commerce:
                return ["cart", "creditcard", "gift"]
            case .communication:
                return ["message", "envelope", "bell"]
            case .organization:
                return ["calendar", "bookmark", "tag"]
            case .development:
                return ["shippingbox.fill", "swift", "arrow.triangle.branch", "terminal"]
            case .status:
                return ["checkmark.circle.fill", "circle", "exclamationmark.triangle"]
            case .actions:
                return ["pencil", "trash", "square.and.arrow.up", "doc.on.doc"]
            }
        }
    }
    
    // MARK: - Icon Resolution
    
    /// Get icon for card type
    static func icon(for type: String) -> String {
        systemIcons[type.lowercased()] ?? systemIcons["default"]!
    }
    
    /// Get icon for file extension
    static func icon(forExtension ext: String) -> String {
        switch ext.lowercased() {
        case "swift": return "swift"
        case "md", "txt": return "doc.text"
        case "jpg", "png", "gif": return "photo"
        case "mp4", "mov": return "video"
        case "mp3", "wav": return "music.note"
        case "zip", "tar", "gz": return "archivebox"
        default: return "doc"
        }
    }
    
    /// Get icon for FlowKit package
    static func icon(forFlowKitPackage package: String) -> String {
        let packageName = package.lowercased()
        
        if packageName.contains("idea") { return "lightbulb" }
        if packageName.contains("icon") { return "photo" }
        if packageName.contains("chat") { return "message" }
        if packageName.contains("terminal") || packageName.contains("command") { return "terminal" }
        if packageName.contains("workflow") { return "arrow.triangle.branch" }
        if packageName.contains("project") { return "folder" }
        if packageName.contains("scaffold") { return "hammer" }
        
        return "shippingbox.fill"
    }
    
    /// Get all icons for category
    static func icons(for category: Category) -> [String] {
        category.icons
    }
    
    /// Search icons
    static func search(_ query: String) -> [String] {
        systemIcons.filter { key, _ in
            key.localizedCaseInsensitiveContains(query)
        }.map { $0.value }
    }
}

// MARK: - Icon Colors

struct CardIconColors {
    
    static let colors: [String: String] = [
        // FlowKit
        "flowkit": "#007AFF",
        "swift": "#F05138",
        
        // Status
        "active": "#34C759",
        "inactive": "#8E8E93",
        "warning": "#FF9500",
        "error": "#FF3B30",
        "success": "#34C759",
        
        // Media
        "image": "#5856D6",
        "video": "#AF52DE",
        "audio": "#FF2D55",
        
        // Development
        "code": "#5AC8FA",
        "terminal": "#30B0C7",
        "git": "#F05138",
        
        // Default
        "default": "#8E8E93"
    ]
    
    /// Get color for icon type
    static func color(for type: String) -> String {
        colors[type.lowercased()] ?? colors["default"]!
    }
}

// MARK: - Icon Badges

struct CardIconBadges {
    
    enum BadgeType {
        case count(Int)
        case status(String)
        case flag
        case dot
        
        var description: String {
            switch self {
            case .count(let n): return "\(n)"
            case .status(let s): return s
            case .flag: return "!"
            case .dot: return "•"
            }
        }
    }
    
    enum BadgeColor {
        case red
        case green
        case blue
        case yellow
        case gray
        
        var hex: String {
            switch self {
            case .red: return "#FF3B30"
            case .green: return "#34C759"
            case .blue: return "#007AFF"
            case .yellow: return "#FF9500"
            case .gray: return "#8E8E93"
            }
        }
    }
    
    struct Badge {
        let type: BadgeType
        let color: BadgeColor
        let position: BadgePosition
    }
    
    enum BadgePosition {
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
    }
}

// MARK: - Icon Presets

struct CardIconPresets {
    
    static let presets: [String: (icon: String, color: String)] = [
        "flowkit-project": ("shippingbox.fill", "#007AFF"),
        "swift-package": ("shippingbox", "#F05138"),
        "active-project": ("folder.fill", "#34C759"),
        "archived-project": ("archivebox", "#8E8E93"),
        "favorite-project": ("star.fill", "#FF9500"),
        "code-file": ("chevron.left.forwardslash.chevron.right", "#5AC8FA"),
        "image-gallery": ("photo.stack", "#5856D6"),
        "video-library": ("video.fill", "#AF52DE"),
        "audio-track": ("music.note", "#FF2D55"),
        "git-repository": ("arrow.triangle.branch", "#F05138"),
        "terminal-session": ("terminal.fill", "#30B0C7"),
        "chat-conversation": ("message.fill", "#007AFF"),
        "notification-center": ("bell.fill", "#FF9500")
    ]
    
    /// Get preset configuration
    static func preset(for key: String) -> (icon: String, color: String)? {
        presets[key]
    }
}
