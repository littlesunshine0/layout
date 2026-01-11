import Foundation

// MARK: - Category Model

struct CategoryModel {
    var width: CGFloat
    var backgroundColor: String
    var showsToolbar: Bool
    var toolbarHeight: CGFloat
    var itemHeight: CGFloat
    var connectsToToolbar: Bool
    var categories: [Category]
    
    struct Category: Identifiable {
        let id = UUID()
        let name: String
        let icon: String
        let count: Int
        let color: String?
        
        init(name: String, icon: String, count: Int = 0, color: String? = nil) {
            self.name = name
            self.icon = icon
            self.count = count
            self.color = color
        }
    }
    
    // Mock data factory
    static func mock() -> CategoryModel {
        CategoryModel(
            width: 200,
            backgroundColor: "#2C2C2E",
            showsToolbar: true,
            toolbarHeight: 44,
            itemHeight: 32,
            connectsToToolbar: true,
            categories: [
                Category(name: "All Projects", icon: "folder", count: 12),
                Category(name: "Recent", icon: "clock", count: 5),
                Category(name: "Favorites", icon: "star.fill", count: 3, color: "#FFD700"),
                Category(name: "Templates", icon: "doc.text.image", count: 8),
                Category(name: "Archived", icon: "archivebox", count: 15)
            ]
        )
    }
    
    // Property file loader
    static func fromProperties(_ basePath: String) -> CategoryModel {
        // TODO: Load from property files
        return mock()
    }
}
