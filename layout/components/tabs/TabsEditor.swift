import Foundation

// MARK: - Tabs Editor

@available(macOS 10.15, iOS 13.0, *)
struct TabsEditor {
    
    // MARK: - Validation
    
    static func validateModel(_ model: TabsModel) -> [String] {
        var errors: [String] = []
        
        if model.height <= 0 {
            errors.append("Height must be greater than 0")
        }
        
        if model.minWidth <= 0 || model.minWidth > model.maxWidth {
            errors.append("Invalid width range")
        }
        
        if model.spacing < 0 {
            errors.append("Spacing cannot be negative")
        }
        
        if model.maxTabs <= 0 {
            errors.append("Max tabs must be greater than 0")
        }
        
        return errors
    }
    
    static func validateTab(_ tab: TabsModel.Tab) -> [String] {
        var errors: [String] = []
        
        if tab.title.isEmpty {
            errors.append("Title cannot be empty")
        }
        
        if tab.order < 0 {
            errors.append("Order cannot be negative")
        }
        
        return errors
    }
    
    // MARK: - Transformations
    
    static func scaleModel(_ model: inout TabsModel, factor: Double) {
        model.height *= factor
        model.minWidth *= factor
        model.maxWidth *= factor
        model.spacing *= factor
    }
    
    static func setStyle(_ model: inout TabsModel, style: TabsModel.TabStyle) {
        model.tabStyle = style
    }
    
    static func resetToDefaults(_ model: inout TabsModel) {
        model = TabsModel.mock()
    }
    
    // MARK: - Tab Transformations
    
    static func renameTab(_ tab: inout TabsModel.Tab, newTitle: String) {
        tab.title = newTitle
        tab.lastAccessedAt = Date()
    }
    
    static func setIcon(_ tab: inout TabsModel.Tab, icon: String?) {
        tab.icon = icon
    }
    
    static func setBadge(_ tab: inout TabsModel.Tab, badge: String?) {
        tab.badge = badge
    }
    
    static func toggleClosable(_ tab: inout TabsModel.Tab) {
        tab.closable.toggle()
    }
    
    static func togglePinned(_ tab: inout TabsModel.Tab) {
        tab.isPinned.toggle()
    }
    
    // MARK: - Batch Operations
    
    static func batchSetClosable(_ tabs: inout [TabsModel.Tab], closable: Bool) {
        for index in tabs.indices {
            tabs[index].closable = closable
        }
    }
    
    static func batchClearBadges(_ tabs: inout [TabsModel.Tab]) {
        for index in tabs.indices {
            tabs[index].badge = nil
        }
    }
    
    static func batchSetIcons(_ tabs: inout [TabsModel.Tab], icon: String) {
        for index in tabs.indices {
            tabs[index].icon = icon
        }
    }
    
    // MARK: - Sorting
    
    static func sortByTitle(_ tabs: inout [TabsModel.Tab]) {
        tabs.sort { $0.title < $1.title }
        updateOrders(&tabs)
    }
    
    static func sortByLastAccessed(_ tabs: inout [TabsModel.Tab]) {
        tabs.sort { $0.lastAccessedAt > $1.lastAccessedAt }
        updateOrders(&tabs)
    }
    
    static func sortByPinned(_ tabs: inout [TabsModel.Tab]) {
        tabs.sort { $0.isPinned && !$1.isPinned }
        updateOrders(&tabs)
    }
    
    private static func updateOrders(_ tabs: inout [TabsModel.Tab]) {
        for (index, _) in tabs.enumerated() {
            tabs[index].order = index
        }
    }
    
    // MARK: - Clone Operations
    
    static func cloneTab(_ tab: TabsModel.Tab) -> TabsModel.Tab {
        TabsModel.Tab(
            title: "\(tab.title) Copy",
            icon: tab.icon,
            closable: tab.closable,
            badge: tab.badge,
            metadata: tab.metadata,
            order: tab.order + 1,
            isPinned: false
        )
    }
}
