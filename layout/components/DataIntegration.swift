import Foundation
import Combine

// MARK: - Property Loader
// Loads properties from file system (integrates with existing window property system)

class PropertyLoader {
    static let shared = PropertyLoader()
    
    private let fileManager = FileManager.default
    private let basePath = "/workspaces/layout/layout/components"
    
    // Load string property
    func loadString(component: String, property: String, defaultValue: String = "") -> String {
        let path = "\(basePath)/\(component)/properties/\(property)"
        guard let content = try? String(contentsOfFile: path, encoding: .utf8) else {
            return defaultValue
        }
        return content.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // Load integer property
    func loadInt(component: String, property: String, defaultValue: Int = 0) -> Int {
        let value = loadString(component: component, property: property)
        return Int(value) ?? defaultValue
    }
    
    // Load double property
    func loadDouble(component: String, property: String, defaultValue: Double = 0.0) -> Double {
        let value = loadString(component: component, property: property)
        return Double(value) ?? defaultValue
    }
    
    // Load boolean property
    func loadBool(component: String, property: String, defaultValue: Bool = false) -> Bool {
        let value = loadString(component: component, property: property).lowercased()
        return value == "true" || value == "yes" || value == "1"
    }
    
    // Load array property (comma-separated)
    func loadArray(component: String, property: String, defaultValue: [String] = []) -> [String] {
        let value = loadString(component: component, property: property)
        guard !value.isEmpty else { return defaultValue }
        return value.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
    }
    
    // Save property
    func saveProperty(component: String, property: String, value: String) throws {
        let path = "\(basePath)/\(component)/properties/\(property)"
        try value.write(toFile: path, atomically: true, encoding: .utf8)
    }
}

// MARK: - Real Data Integration Point

/// Use this class to connect mock ViewModels to real data sources
/// Example:
/// ```
/// let realDataSource = RealTitleBarDataSource()
/// titleBarViewModel.connectToRealData(realDataSource)
/// ```

class DataIntegration {
    
    // MARK: - Load Models from Properties
    
    static func loadTitleBarModel() -> TitleBarModel {
        let loader = PropertyLoader.shared
        
        return TitleBarModel(
            height: CGFloat(loader.loadInt(component: "titlebar", property: "TitleBarHeight", defaultValue: 52)),
            backgroundColor: loader.loadString(component: "titlebar", property: "TitleBarBackgroundColor", defaultValue: "#1C1C1E"),
            alignment: TitleBarModel.Alignment(rawValue: loader.loadString(component: "titlebar", property: "TitleBarAlignment", defaultValue: "leading")) ?? .leading,
            showsTitle: loader.loadBool(component: "titlebar", property: "TitleBarShowsTitle", defaultValue: true),
            showsIcon: loader.loadBool(component: "titlebar", property: "TitleBarShowsIcon", defaultValue: true),
            iconSize: CGFloat(loader.loadInt(component: "titlebar", property: "TitleBarIconSize", defaultValue: 24)),
            buttons: loader.loadArray(component: "titlebar", property: "TitleBarButtons")
                .compactMap { TitleBarModel.TitleBarButton(rawValue: $0) },
            buttonsPosition: TitleBarModel.Alignment(rawValue: loader.loadString(component: "titlebar", property: "TitleBarButtonsPosition", defaultValue: "trailing")) ?? .trailing,
            dividerVisible: loader.loadBool(component: "titlebar", property: "TitleBarDividerVisible", defaultValue: true)
        )
    }
    
    static func loadNavigationModel() -> NavigationModel {
        let loader = PropertyLoader.shared
        
        // Load items from property file
        let itemNames = loader.loadArray(component: "navigation", property: "NavigationItems")
        let items = itemNames.map { name -> NavigationModel.NavigationItem in
            NavigationModel.NavigationItem(
                name: name,
                icon: iconForNavigationItem(name),
                badge: nil // TODO: Load from real data
            )
        }
        
        return NavigationModel(
            width: CGFloat(loader.loadInt(component: "navigation", property: "NavigationWidth", defaultValue: 72)),
            expandedWidth: CGFloat(loader.loadInt(component: "navigation", property: "NavigationExpandedWidth", defaultValue: 220)),
            isExpanded: loader.loadBool(component: "navigation", property: "NavigationIsExpanded", defaultValue: false),
            backgroundColor: loader.loadString(component: "navigation", property: "NavigationBackgroundColor", defaultValue: "#2C2C2E"),
            iconSize: CGFloat(loader.loadInt(component: "navigation", property: "NavigationIconSize", defaultValue: 28)),
            itemSpacing: CGFloat(loader.loadInt(component: "navigation", property: "NavigationItemSpacing", defaultValue: 12)),
            showLabels: loader.loadBool(component: "navigation", property: "NavigationShowLabels", defaultValue: false),
            items: items,
            connectsToTitleBar: loader.loadBool(component: "navigation", property: "NavigationConnectsToTitleBar", defaultValue: true)
        )
    }
    
    static func loadCategoryModel() -> CategoryModel {
        let loader = PropertyLoader.shared
        
        return CategoryModel(
            width: CGFloat(loader.loadInt(component: "category", property: "CategoryWidth", defaultValue: 200)),
            backgroundColor: loader.loadString(component: "category", property: "CategoryBackgroundColor", defaultValue: "#2C2C2E"),
            showsToolbar: loader.loadBool(component: "category", property: "CategoryShowsToolbar", defaultValue: true),
            toolbarHeight: CGFloat(loader.loadInt(component: "category", property: "CategoryToolbarHeight", defaultValue: 44)),
            itemHeight: CGFloat(loader.loadInt(component: "category", property: "CategoryItemHeight", defaultValue: 32)),
            connectsToToolbar: loader.loadBool(component: "category", property: "CategoryConnectsToToolbar", defaultValue: true),
            categories: [] // TODO: Load from real data
        )
    }
    
    static func loadPanelModel() -> PanelModel {
        let loader = PropertyLoader.shared
        
        let typeNames = loader.loadArray(component: "panel", property: "PanelTypes")
        let types = typeNames.compactMap { PanelModel.PanelType(rawValue: $0) }
        
        return PanelModel(
            maxCount: loader.loadInt(component: "panel", property: "PanelMaxCount", defaultValue: 3),
            floats: loader.loadBool(component: "panel", property: "PanelFloats", defaultValue: true),
            minWidth: CGFloat(loader.loadInt(component: "panel", property: "PanelMinWidth", defaultValue: 320)),
            minHeight: CGFloat(loader.loadInt(component: "panel", property: "PanelMinHeight", defaultValue: 240)),
            types: types,
            cardCornerRadius: CGFloat(loader.loadInt(component: "panel", property: "PanelCardCornerRadius", defaultValue: 12)),
            cardShadow: loader.loadBool(component: "panel", property: "PanelCardShadow", defaultValue: true),
            cardBackgroundColor: loader.loadString(component: "panel", property: "PanelCardBackgroundColor", defaultValue: "#1C1C1E"),
            activePanels: [] // TODO: Load from saved state
        )
    }
    
    static func loadContentModel() -> ContentModel {
        let loader = PropertyLoader.shared
        
        return ContentModel(
            backgroundColor: loader.loadString(component: "content", property: "ContentBackgroundColor", defaultValue: "#000000"),
            showsInspector: loader.loadBool(component: "content", property: "ContentShowsInspector", defaultValue: false),
            inspectorWidth: CGFloat(loader.loadInt(component: "content", property: "InspectorWidth", defaultValue: 280)),
            inspectorPosition: ContentModel.Position(rawValue: loader.loadString(component: "content", property: "InspectorPosition", defaultValue: "trailing")) ?? .trailing,
            selectedItem: nil,
            items: [] // TODO: Load from real data
        )
    }
    
    // MARK: - Helpers
    
    private static func iconForNavigationItem(_ name: String) -> String {
        switch name {
        case "projects": return "folder"
        case "packages": return "cube.box"
        case "chat": return "bubble.left.and.bubble.right"
        case "terminal": return "terminal"
        case "settings": return "gearshape"
        case "help": return "questionmark.circle"
        default: return "circle"
        }
    }
}
