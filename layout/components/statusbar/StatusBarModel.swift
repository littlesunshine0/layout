import Foundation
import Combine

// MARK: - StatusBar Model

struct StatusBarModel {
    // Layout Properties
    var height: Double
    var updateInterval: TimeInterval
    
    // Visual Properties
    var backgroundColor: String
    var font: String
    var textColor: String
    var progressColor: String
    var separator: String
    var animation: String
    
    // Control Properties
    var showsLeft: Bool
    var showsCenter: Bool
    var showsRight: Bool
    var showsProgress: Bool
    
    // MARK: - Enums
    
    enum StatusPosition: String, CaseIterable {
        case leading
        case center
        case trailing
        
        var description: String {
            switch self {
            case .leading: return "Leading"
            case .center: return "Center"
            case .trailing: return "Trailing"
            }
        }
    }
    
    // MARK: - StatusItem Data
    
    struct StatusItem: Identifiable {
        let id: String
        var position: StatusPosition
        var icon: String?
        var text: String
        var action: String?
        var metadata: [String: String]
        var isVisible: Bool
        var order: Int
        var updatedAt: Date
        
        init(
            id: String = UUID().uuidString,
            position: StatusPosition,
            icon: String? = nil,
            text: String,
            action: String? = nil,
            metadata: [String: String] = [:],
            isVisible: Bool = true,
            order: Int = 0,
            updatedAt: Date = Date()
        ) {
            self.id = id
            self.position = position
            self.icon = icon
            self.text = text
            self.action = action
            self.metadata = metadata
            self.isVisible = isVisible
            self.order = order
            self.updatedAt = updatedAt
        }
    }
    
    // MARK: - Mock Data
    
    static func mock() -> StatusBarModel {
        StatusBarModel(
            height: 24,
            updateInterval: 1.0,
            backgroundColor: "#F0F0F0",
            font: "System-Small",
            textColor: "#333333",
            progressColor: "#007AFF",
            separator: "|",
            animation: "fade",
            showsLeft: true,
            showsCenter: true,
            showsRight: true,
            showsProgress: true
        )
    }
    
    static func mockItems() -> [StatusItem] {
        [
            StatusItem(
                position: .leading,
                icon: "text.alignleft",
                text: "Lines: 1234",
                order: 0
            ),
            StatusItem(
                position: .leading,
                icon: "flame",
                text: "CPU: 12%",
                order: 1
            ),
            StatusItem(
                position: .center,
                text: "Ready",
                order: 0
            ),
            StatusItem(
                position: .trailing,
                icon: "clock",
                text: "14:32",
                order: 0
            ),
            StatusItem(
                position: .trailing,
                icon: "wifi",
                text: "Connected",
                order: 1
            ),
            StatusItem(
                position: .trailing,
                icon: "battery.100",
                text: "100%",
                order: 2
            )
        ]
    }
    
    // MARK: - Property Loading
    
    static func fromProperties() -> StatusBarModel {
        StatusBarModel(
            height: PropertyLoader.shared.loadDouble(for: "StatusBarHeight") ?? 24,
            updateInterval: PropertyLoader.shared.loadDouble(for: "StatusBarUpdateInterval") ?? 1.0,
            backgroundColor: PropertyLoader.shared.loadString(for: "StatusBarBackgroundColor") ?? "#F0F0F0",
            font: PropertyLoader.shared.loadString(for: "StatusBarFont") ?? "System-Small",
            textColor: PropertyLoader.shared.loadString(for: "StatusBarTextColor") ?? "#333333",
            progressColor: PropertyLoader.shared.loadString(for: "StatusBarProgressColor") ?? "#007AFF",
            separator: PropertyLoader.shared.loadString(for: "StatusBarSeparator") ?? "|",
            animation: PropertyLoader.shared.loadString(for: "StatusBarAnimation") ?? "fade",
            showsLeft: PropertyLoader.shared.loadBool(for: "StatusBarShowsLeft") ?? true,
            showsCenter: PropertyLoader.shared.loadBool(for: "StatusBarShowsCenter") ?? true,
            showsRight: PropertyLoader.shared.loadBool(for: "StatusBarShowsRight") ?? true,
            showsProgress: PropertyLoader.shared.loadBool(for: "StatusBarShowsProgress") ?? true
        )
    }
}
