import Foundation

// MARK: - Content Model

struct ContentModel {
    var backgroundColor: String
    var showsInspector: Bool
    var inspectorWidth: CGFloat
    var inspectorPosition: Position
    var selectedItem: ContentItem?
    var items: [ContentItem]
    
    enum Position: String {
        case leading, trailing
    }
    
    struct ContentItem: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String?
        let icon: String
        let type: ItemType
        let metadata: [String: String]
        
        enum ItemType: String {
            case project, package, file, folder
        }
        
        init(title: String, subtitle: String? = nil, icon: String, type: ItemType, metadata: [String: String] = [:]) {
            self.title = title
            self.subtitle = subtitle
            self.icon = icon
            self.type = type
            self.metadata = metadata
        }
    }
    
    // Mock data factory
    static func mock() -> ContentModel {
        ContentModel(
            backgroundColor: "#000000",
            showsInspector: false,
            inspectorWidth: 280,
            inspectorPosition: .trailing,
            selectedItem: nil,
            items: [
                ContentItem(
                    title: "TodoApp",
                    subtitle: "Personal task manager",
                    icon: "checkmark.circle.fill",
                    type: .project,
                    metadata: ["status": "active", "lastModified": "2 hours ago"]
                ),
                ContentItem(
                    title: "WeatherKit",
                    subtitle: "Weather data package",
                    icon: "cloud.sun.fill",
                    type: .package,
                    metadata: ["version": "1.0.0", "dependencies": "3"]
                ),
                ContentItem(
                    title: "ChatBot",
                    subtitle: "AI-powered assistant",
                    icon: "bubble.left.and.bubble.right.fill",
                    type: .project,
                    metadata: ["status": "in-progress", "kits": "5"]
                )
            ]
        )
    }
    
    // Property file loader
    static func fromProperties(_ basePath: String) -> ContentModel {
        // TODO: Load from property files
        return mock()
    }
}
