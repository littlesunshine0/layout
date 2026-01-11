import Foundation
import Combine

// MARK: - Tabs Model

struct TabsModel {
    // Layout Properties
    var height: Double
    var minWidth: Double
    var maxWidth: Double
    var spacing: Double
    
    // Visual Properties
    var backgroundColor: String
    var activeColor: String
    var inactiveColor: String
    var borderColor: String
    var font: String
    var tabStyle: TabStyle
    
    // Control Properties
    var showsCloseButton: Bool
    var showsIcons: Bool
    var allowsReordering: Bool
    var maxTabs: Int
    
    // MARK: - Enums
    
    enum TabStyle: String, CaseIterable {
        case bar
        case pills
        case segments
        
        var description: String {
            switch self {
            case .bar: return "Bar"
            case .pills: return "Pills"
            case .segments: return "Segments"
            }
        }
        
        var icon: String {
            switch self {
            case .bar: return "rectangle.split.3x1"
            case .pills: return "capsule"
            case .segments: return "square.split.3x1"
            }
        }
    }
    
    // MARK: - Tab Data
    
    struct Tab: Identifiable {
        let id: String
        var title: String
        var icon: String?
        var closable: Bool
        var isActive: Bool
        var badge: String?
        var metadata: [String: String]
        var order: Int
        var isPinned: Bool
        var createdAt: Date
        var lastAccessedAt: Date
        
        init(
            id: String = UUID().uuidString,
            title: String,
            icon: String? = nil,
            closable: Bool = true,
            isActive: Bool = false,
            badge: String? = nil,
            metadata: [String: String] = [:],
            order: Int = 0,
            isPinned: Bool = false,
            createdAt: Date = Date(),
            lastAccessedAt: Date = Date()
        ) {
            self.id = id
            self.title = title
            self.icon = icon
            self.closable = closable
            self.isActive = isActive
            self.badge = badge
            self.metadata = metadata
            self.order = order
            self.isPinned = isPinned
            self.createdAt = createdAt
            self.lastAccessedAt = lastAccessedAt
        }
    }
    
    // MARK: - Mock Data
    
    static func mock() -> TabsModel {
        TabsModel(
            height: 40,
            minWidth: 100,
            maxWidth: 250,
            spacing: 4,
            backgroundColor: "#F0F0F0",
            activeColor: "#FFFFFF",
            inactiveColor: "#E0E0E0",
            borderColor: "#CCCCCC",
            font: "System",
            tabStyle: .bar,
            showsCloseButton: true,
            showsIcons: true,
            allowsReordering: true,
            maxTabs: 20
        )
    }
    
    static func mockTabs() -> [Tab] {
        [
            Tab(
                title: "Home",
                icon: "house.fill",
                closable: false,
                isActive: true,
                order: 0,
                isPinned: true
            ),
            Tab(
                title: "Documents",
                icon: "doc.text",
                badge: "5",
                order: 1
            ),
            Tab(
                title: "Settings",
                icon: "gear",
                order: 2
            ),
            Tab(
                title: "Profile",
                icon: "person.circle",
                order: 3
            ),
            Tab(
                title: "Messages",
                icon: "message",
                badge: "12",
                order: 4
            ),
            Tab(
                title: "Notifications",
                icon: "bell",
                badge: "3",
                order: 5
            ),
            Tab(
                title: "Calendar",
                icon: "calendar",
                order: 6
            ),
            Tab(
                title: "Tasks",
                icon: "checkmark.circle",
                badge: "8",
                order: 7
            )
        ]
    }
    
    // MARK: - Property Loading
    
    static func fromProperties() -> TabsModel {
        TabsModel(
            height: PropertyLoader.shared.loadDouble(for: "TabsHeight") ?? 40,
            minWidth: PropertyLoader.shared.loadDouble(for: "TabsMinWidth") ?? 100,
            maxWidth: PropertyLoader.shared.loadDouble(for: "TabsMaxWidth") ?? 250,
            spacing: PropertyLoader.shared.loadDouble(for: "TabsSpacing") ?? 4,
            backgroundColor: PropertyLoader.shared.loadString(for: "TabsBackgroundColor") ?? "#F0F0F0",
            activeColor: PropertyLoader.shared.loadString(for: "TabsActiveColor") ?? "#FFFFFF",
            inactiveColor: PropertyLoader.shared.loadString(for: "TabsInactiveColor") ?? "#E0E0E0",
            borderColor: PropertyLoader.shared.loadString(for: "TabsBorderColor") ?? "#CCCCCC",
            font: PropertyLoader.shared.loadString(for: "TabsFont") ?? "System",
            tabStyle: TabStyle(rawValue: PropertyLoader.shared.loadString(for: "TabsTabStyle") ?? "bar") ?? .bar,
            showsCloseButton: PropertyLoader.shared.loadBool(for: "TabsShowsCloseButton") ?? true,
            showsIcons: PropertyLoader.shared.loadBool(for: "TabsShowsIcons") ?? true,
            allowsReordering: PropertyLoader.shared.loadBool(for: "TabsAllowsReordering") ?? true,
            maxTabs: PropertyLoader.shared.loadInt(for: "TabsMaxTabs") ?? 20
        )
    }
}
