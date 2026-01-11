import Foundation

// MARK: - Tabs Preview

@available(macOS 10.15, iOS 13.0, *)
struct TabsPreview {
    
    // MARK: - Configuration 1: Default Bar Tabs
    
    static func defaultPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        let model = TabsModel.mock()
        let tabs = TabsModel.mockTabs()
        return (model, tabs)
    }
    
    // MARK: - Configuration 2: Compact Tabs
    
    static func compactPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        let model = TabsGenerator.generateCompact()
        let tabs = Array(TabsModel.mockTabs().prefix(4))
        return (model, tabs)
    }
    
    // MARK: - Configuration 3: Pills Style
    
    static func pillsPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        let model = TabsGenerator.generatePills()
        let tabs = TabsModel.mockTabs()
        return (model, tabs)
    }
    
    // MARK: - Configuration 4: Segments Style
    
    static func segmentsPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        let model = TabsGenerator.generateSegments()
        let tabs = Array(TabsModel.mockTabs().prefix(4))
        return (model, tabs)
    }
    
    // MARK: - Configuration 5: With Badges
    
    static func badgesPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        let model = TabsModel.mock()
        let tabs = TabsModel.mockTabs().map { var tab = $0; tab.badge = "\(Int.random(in: 1...99))"; return tab }
        return (model, tabs)
    }
    
    // MARK: - Configuration 6: Minimal (No Icons, No Close)
    
    static func minimalPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        var model = TabsModel.mock()
        model.showsIcons = false
        model.showsCloseButton = false
        let tabs = Array(TabsModel.mockTabs().prefix(3))
        return (model, tabs)
    }
    
    // MARK: - Configuration 7: With Pinned Tabs
    
    static func pinnedPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        let model = TabsModel.mock()
        var tabs = TabsModel.mockTabs()
        tabs[0].isPinned = true
        tabs[1].isPinned = true
        return (model, tabs)
    }
    
    // MARK: - Configuration 8: Many Tabs
    
    static func manyTabsPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        let model = TabsModel.mock()
        let tabs = TabsGenerator.generateBatchTabs(count: 15, prefix: "Tab")
        return (model, tabs)
    }
    
    // MARK: - Configuration 9: Single Tab
    
    static func singleTabPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        let model = TabsModel.mock()
        let tabs = [TabsModel.mockTabs().first!]
        return (model, tabs)
    }
    
    // MARK: - Configuration 10: Dark Theme
    
    static func darkThemePreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        var model = TabsModel.mock()
        model.backgroundColor = "#2D2D2D"
        model.activeColor = "#3D3D3D"
        model.inactiveColor = "#1D1D1D"
        model.borderColor = "#505050"
        let tabs = TabsModel.mockTabs()
        return (model, tabs)
    }
    
    // MARK: - Configuration 11: Colorful Pills
    
    static func colorfulPillsPreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        var model = TabsGenerator.generatePills()
        model.activeColor = "#FF6B6B"
        model.borderColor = "#FF6B6B"
        let tabs = TabsModel.mockTabs()
        return (model, tabs)
    }
    
    // MARK: - Configuration 12: Browser-Style Tabs
    
    static func browserStylePreview() -> (model: TabsModel, tabs: [TabsModel.Tab]) {
        var model = TabsModel.mock()
        model.maxWidth = 200
        model.showsCloseButton = true
        model.showsIcons = true
        model.allowsReordering = true
        let tabs = TabsGenerator.generateBatchTabs(count: 8, prefix: "Page")
        return (model, tabs)
    }
    
    // MARK: - All Configurations
    
    static func allConfigurations() -> [(name: String, model: TabsModel, tabs: [TabsModel.Tab])] {
        [
            ("Default Bar", defaultPreview().model, defaultPreview().tabs),
            ("Compact", compactPreview().model, compactPreview().tabs),
            ("Pills Style", pillsPreview().model, pillsPreview().tabs),
            ("Segments Style", segmentsPreview().model, segmentsPreview().tabs),
            ("With Badges", badgesPreview().model, badgesPreview().tabs),
            ("Minimal", minimalPreview().model, minimalPreview().tabs),
            ("With Pinned", pinnedPreview().model, pinnedPreview().tabs),
            ("Many Tabs", manyTabsPreview().model, manyTabsPreview().tabs),
            ("Single Tab", singleTabPreview().model, singleTabPreview().tabs),
            ("Dark Theme", darkThemePreview().model, darkThemePreview().tabs),
            ("Colorful Pills", colorfulPillsPreview().model, colorfulPillsPreview().tabs),
            ("Browser Style", browserStylePreview().model, browserStylePreview().tabs)
        ]
    }
}
