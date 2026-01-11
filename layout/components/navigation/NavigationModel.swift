import Foundation

// MARK: - Navigation Model

struct NavigationModel {
    var width: CGFloat
    var expandedWidth: CGFloat
    var isExpanded: Bool
    var backgroundColor: String
    var iconSize: CGFloat
    var itemSpacing: CGFloat
    var showLabels: Bool
    var items: [NavigationItem]
    var connectsToTitleBar: Bool
    
    struct NavigationItem: Identifiable {
        let id = UUID()
        let name: String
        let icon: String
        let badge: Int?
        
        init(name: String, icon: String, badge: Int? = nil) {
            self.name = name
            self.icon = icon
            self.badge = badge
        }
    }
    
    // Mock data factory
    static func mock() -> NavigationModel {
        NavigationModel(
            width: 72,
            expandedWidth: 220,
            isExpanded: false,
            backgroundColor: "#2C2C2E",
            iconSize: 28,
            itemSpacing: 12,
            showLabels: false,
            items: [
                NavigationItem(name: "projects", icon: "folder", badge: 3),
                NavigationItem(name: "packages", icon: "cube.box", badge: nil),
                NavigationItem(name: "chat", icon: "bubble.left.and.bubble.right", badge: 2),
                NavigationItem(name: "terminal", icon: "terminal"),
                NavigationItem(name: "settings", icon: "gearshape"),
                NavigationItem(name: "help", icon: "questionmark.circle")
            ],
            connectsToTitleBar: true
        )
    }
    
    // Property file loader
    static func fromProperties(_ basePath: String) -> NavigationModel {
        // TODO: Load from property files
        return mock()
    }
}
