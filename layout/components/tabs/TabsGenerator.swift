import Foundation

// MARK: - Tabs Generator

@available(macOS 10.15, iOS 13.0, *)
struct TabsGenerator {
    
    // MARK: - Template Generation
    
    static func generateDefault() -> TabsModel {
        TabsModel.mock()
    }
    
    static func generateCompact() -> TabsModel {
        TabsModel(
            height: 32,
            minWidth: 80,
            maxWidth: 150,
            spacing: 2,
            backgroundColor: "#F5F5F5",
            activeColor: "#FFFFFF",
            inactiveColor: "#E5E5E5",
            borderColor: "#DDDDDD",
            font: "System-Small",
            tabStyle: .segments,
            showsCloseButton: false,
            showsIcons: false,
            allowsReordering: false,
            maxTabs: 10
        )
    }
    
    static func generatePills() -> TabsModel {
        TabsModel(
            height: 44,
            minWidth: 120,
            maxWidth: 300,
            spacing: 8,
            backgroundColor: "#FFFFFF",
            activeColor: "#007AFF",
            inactiveColor: "#F0F0F0",
            borderColor: "#007AFF",
            font: "System-Medium",
            tabStyle: .pills,
            showsCloseButton: true,
            showsIcons: true,
            allowsReordering: true,
            maxTabs: 15
        )
    }
    
    static func generateSegments() -> TabsModel {
        TabsModel(
            height: 36,
            minWidth: 100,
            maxWidth: 200,
            spacing: 0,
            backgroundColor: "#E8E8E8",
            activeColor: "#FFFFFF",
            inactiveColor: "transparent",
            borderColor: "#CCCCCC",
            font: "System",
            tabStyle: .segments,
            showsCloseButton: false,
            showsIcons: false,
            allowsReordering: false,
            maxTabs: 8
        )
    }
    
    // MARK: - Tab Templates
    
    static func generateTab(title: String, icon: String? = nil) -> TabsModel.Tab {
        TabsModel.Tab(title: title, icon: icon)
    }
    
    static func generatePinnedTab(title: String, icon: String) -> TabsModel.Tab {
        TabsModel.Tab(title: title, icon: icon, closable: false, isPinned: true)
    }
    
    static func generateTabWithBadge(title: String, icon: String?, badge: String) -> TabsModel.Tab {
        TabsModel.Tab(title: title, icon: icon, badge: badge)
    }
    
    // MARK: - JSON Export/Import
    
    static func exportToJSON(model: TabsModel) -> String {
        let dict: [String: Any] = [
            "height": model.height,
            "minWidth": model.minWidth,
            "maxWidth": model.maxWidth,
            "spacing": model.spacing,
            "backgroundColor": model.backgroundColor,
            "activeColor": model.activeColor,
            "inactiveColor": model.inactiveColor,
            "borderColor": model.borderColor,
            "font": model.font,
            "tabStyle": model.tabStyle.rawValue,
            "showsCloseButton": model.showsCloseButton,
            "showsIcons": model.showsIcons,
            "allowsReordering": model.allowsReordering,
            "maxTabs": model.maxTabs
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
              let json = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        
        return json
    }
    
    static func importFromJSON(_ json: String) -> TabsModel? {
        guard let data = json.data(using: .utf8),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        
        return TabsModel(
            height: dict["height"] as? Double ?? 40,
            minWidth: dict["minWidth"] as? Double ?? 100,
            maxWidth: dict["maxWidth"] as? Double ?? 250,
            spacing: dict["spacing"] as? Double ?? 4,
            backgroundColor: dict["backgroundColor"] as? String ?? "#F0F0F0",
            activeColor: dict["activeColor"] as? String ?? "#FFFFFF",
            inactiveColor: dict["inactiveColor"] as? String ?? "#E0E0E0",
            borderColor: dict["borderColor"] as? String ?? "#CCCCCC",
            font: dict["font"] as? String ?? "System",
            tabStyle: TabsModel.TabStyle(rawValue: dict["tabStyle"] as? String ?? "bar") ?? .bar,
            showsCloseButton: dict["showsCloseButton"] as? Bool ?? true,
            showsIcons: dict["showsIcons"] as? Bool ?? true,
            allowsReordering: dict["allowsReordering"] as? Bool ?? true,
            maxTabs: dict["maxTabs"] as? Int ?? 20
        )
    }
    
    // MARK: - CSV Export/Import
    
    static func exportTabsToCSV(_ tabs: [TabsModel.Tab]) -> String {
        var csv = "ID,Title,Icon,Closable,Badge,IsPinned,Order\n"
        
        for tab in tabs {
            csv += "\(tab.id),\(tab.title),\(tab.icon ?? ""),\(tab.closable),\(tab.badge ?? ""),\(tab.isPinned),\(tab.order)\n"
        }
        
        return csv
    }
    
    static func importTabsFromCSV(_ csv: String) -> [TabsModel.Tab] {
        let lines = csv.components(separatedBy: "\n").dropFirst()
        var tabs: [TabsModel.Tab] = []
        
        for line in lines {
            let columns = line.components(separatedBy: ",")
            guard columns.count >= 7 else { continue }
            
            let tab = TabsModel.Tab(
                id: columns[0],
                title: columns[1],
                icon: columns[2].isEmpty ? nil : columns[2],
                closable: columns[3] == "true",
                badge: columns[4].isEmpty ? nil : columns[4],
                order: Int(columns[6]) ?? 0,
                isPinned: columns[5] == "true"
            )
            tabs.append(tab)
        }
        
        return tabs
    }
    
    // MARK: - Batch Generation
    
    static func generateBatchTabs(count: Int, prefix: String = "Tab") -> [TabsModel.Tab] {
        (0..<count).map { index in
            TabsModel.Tab(
                title: "\(prefix) \(index + 1)",
                icon: "doc",
                order: index
            )
        }
    }
}
