import Foundation
import Combine

// MARK: - PathBar Model

struct PathBarModel {
    // Layout Properties
    var height: Double
    var maxSegments: Int
    
    // Visual Properties
    var backgroundColor: String
    var font: String
    var textColor: String
    var separator: String
    var truncationMode: TruncationMode
    
    // Control Properties
    var showsIcons: Bool
    var showsHome: Bool
    var clickableSegments: Bool
    
    // MARK: - Enums
    
    enum TruncationMode: String, CaseIterable {
        case head
        case middle
        case tail
        
        var description: String {
            switch self {
            case .head: return "Head"
            case .middle: return "Middle"
            case .tail: return "Tail"
            }
        }
    }
    
    // MARK: - PathSegment Data
    
    struct PathSegment: Identifiable {
        let id: String
        var name: String
        var path: String
        var icon: String?
        var isClickable: Bool
        var metadata: [String: String]
        var order: Int
        
        init(
            id: String = UUID().uuidString,
            name: String,
            path: String,
            icon: String? = nil,
            isClickable: Bool = true,
            metadata: [String: String] = [:],
            order: Int = 0
        ) {
            self.id = id
            self.name = name
            self.path = path
            self.icon = icon
            self.isClickable = isClickable
            self.metadata = metadata
            self.order = order
        }
    }
    
    // MARK: - Mock Data
    
    static func mock() -> PathBarModel {
        PathBarModel(
            height: 28,
            maxSegments: 8,
            backgroundColor: "#F5F5F5",
            font: "System-Small",
            textColor: "#333333",
            separator: "/",
            truncationMode: .middle,
            showsIcons: true,
            showsHome: true,
            clickableSegments: true
        )
    }
    
    static func mockPaths() -> [[PathSegment]] {
        [
            // Home path
            [
                PathSegment(name: "~", path: "/Users/demo", icon: "house.fill", order: 0),
                PathSegment(name: "Documents", path: "/Users/demo/Documents", icon: "folder.fill", order: 1),
                PathSegment(name: "Projects", path: "/Users/demo/Documents/Projects", icon: "folder.fill", order: 2),
                PathSegment(name: "layout", path: "/Users/demo/Documents/Projects/layout", icon: "folder.fill", order: 3)
            ],
            // Deep path
            [
                PathSegment(name: "~", path: "/Users/demo", icon: "house.fill", order: 0),
                PathSegment(name: "Pictures", path: "/Users/demo/Pictures", icon: "photo.fill", order: 1),
                PathSegment(name: "2024", path: "/Users/demo/Pictures/2024", icon: "folder.fill", order: 2),
                PathSegment(name: "Summer", path: "/Users/demo/Pictures/2024/Summer", icon: "folder.fill", order: 3),
                PathSegment(name: "Vacation", path: "/Users/demo/Pictures/2024/Summer/Vacation", icon: "folder.fill", order: 4)
            ],
            // Root path
            [
                PathSegment(name: "/", path: "/", icon: "internaldrive", order: 0),
                PathSegment(name: "Applications", path: "/Applications", icon: "app.fill", order: 1),
                PathSegment(name: "Utilities", path: "/Applications/Utilities", icon: "folder.fill", order: 2)
            ],
            // File path
            [
                PathSegment(name: "~", path: "/Users/demo", icon: "house.fill", order: 0),
                PathSegment(name: "Desktop", path: "/Users/demo/Desktop", icon: "macwindow", order: 1),
                PathSegment(name: "report.pdf", path: "/Users/demo/Desktop/report.pdf", icon: "doc.richtext", isClickable: false, order: 2)
            ]
        ]
    }
    
    // MARK: - Property Loading
    
    static func fromProperties() -> PathBarModel {
        PathBarModel(
            height: PropertyLoader.shared.loadDouble(for: "PathBarHeight") ?? 28,
            maxSegments: PropertyLoader.shared.loadInt(for: "PathBarMaxSegments") ?? 8,
            backgroundColor: PropertyLoader.shared.loadString(for: "PathBarBackgroundColor") ?? "#F5F5F5",
            font: PropertyLoader.shared.loadString(for: "PathBarFont") ?? "System-Small",
            textColor: PropertyLoader.shared.loadString(for: "PathBarTextColor") ?? "#333333",
            separator: PropertyLoader.shared.loadString(for: "PathBarSeparator") ?? "/",
            truncationMode: TruncationMode(rawValue: PropertyLoader.shared.loadString(for: "PathBarTruncationMode") ?? "middle") ?? .middle,
            showsIcons: PropertyLoader.shared.loadBool(for: "PathBarShowsIcons") ?? true,
            showsHome: PropertyLoader.shared.loadBool(for: "PathBarShowsHome") ?? true,
            clickableSegments: PropertyLoader.shared.loadBool(for: "PathBarClickableSegments") ?? true
        )
    }
}
