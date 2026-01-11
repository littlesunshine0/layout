import Foundation
import Combine

// MARK: - Tabs DataSource Protocol

@available(macOS 10.15, iOS 13.0, *)
protocol TabsDataSource {
    func createTab(_ tab: TabsModel.Tab)
    func updateTab(_ tab: TabsModel.Tab)
    func deleteTab(_ tab: TabsModel.Tab)
    func fetchTabs() -> [TabsModel.Tab]
}

// MARK: - Tabs ViewModel

@available(macOS 10.15, iOS 13.0, *)
final class TabsViewModel: ObservableObject {
    // Published Properties
    @Published var model: TabsModel
    @Published var tabs: [TabsModel.Tab]
    @Published var activeTab: TabsModel.Tab?
    @Published var searchQuery: String = ""
    @Published var isDragging: Bool = false
    @Published var draggedTab: TabsModel.Tab?
    
    // Private
    private var dataSource: TabsDataSource?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init(model: TabsModel = .mock(), tabs: [TabsModel.Tab] = TabsModel.mockTabs()) {
        self.model = model
        self.tabs = tabs.sorted { $0.order < $1.order }
        self.activeTab = tabs.first { $0.isActive }
    }
    
    // MARK: - CRUD Operations
    
    // Create
    func createTab(
        title: String,
        icon: String? = nil,
        closable: Bool = true,
        badge: String? = nil,
        metadata: [String: String] = [:]
    ) {
        guard tabs.count < model.maxTabs else { return }
        
        let newOrder = (tabs.map { $0.order }.max() ?? -1) + 1
        let tab = TabsModel.Tab(
            title: title,
            icon: icon,
            closable: closable,
            badge: badge,
            metadata: metadata,
            order: newOrder
        )
        
        if let dataSource = dataSource {
            dataSource.createTab(tab)
        } else {
            tabs.append(tab)
        }
    }
    
    // Read
    func getTab(byId id: String) -> TabsModel.Tab? {
        tabs.first { $0.id == id }
    }
    
    func filteredTabs() -> [TabsModel.Tab] {
        var filtered = tabs
        
        if !searchQuery.isEmpty {
            filtered = filtered.filter { tab in
                tab.title.localizedCaseInsensitiveContains(searchQuery)
            }
        }
        
        return filtered.sorted { $0.order < $1.order }
    }
    
    func pinnedTabs() -> [TabsModel.Tab] {
        tabs.filter { $0.isPinned }.sorted { $0.order < $1.order }
    }
    
    func unpinnedTabs() -> [TabsModel.Tab] {
        tabs.filter { !$0.isPinned }.sorted { $0.order < $1.order }
    }
    
    // Update
    func updateTab(_ tab: TabsModel.Tab) {
        if let index = tabs.firstIndex(where: { $0.id == tab.id }) {
            var updatedTab = tab
            updatedTab.lastAccessedAt = Date()
            
            if let dataSource = dataSource {
                dataSource.updateTab(updatedTab)
            }
            
            tabs[index] = updatedTab
        }
    }
    
    func renameTab(id: String, newTitle: String) {
        if let index = tabs.firstIndex(where: { $0.id == id }) {
            tabs[index].title = newTitle
            updateTab(tabs[index])
        }
    }
    
    func updateBadge(id: String, badge: String?) {
        if let index = tabs.firstIndex(where: { $0.id == id }) {
            tabs[index].badge = badge
            updateTab(tabs[index])
        }
    }
    
    func togglePin(id: String) {
        if let index = tabs.firstIndex(where: { $0.id == id }) {
            tabs[index].isPinned.toggle()
            reorderTabs()
            updateTab(tabs[index])
        }
    }
    
    // Delete
    func closeTab(_ tab: TabsModel.Tab) {
        guard tab.closable else { return }
        
        if let dataSource = dataSource {
            dataSource.deleteTab(tab)
        }
        
        tabs.removeAll { $0.id == tab.id }
        
        if activeTab?.id == tab.id {
            selectNextTab()
        }
    }
    
    func closeAllTabs(except tab: TabsModel.Tab? = nil) {
        let tabsToClose = tabs.filter { $0.closable && $0.id != tab?.id }
        tabsToClose.forEach { closeTab($0) }
    }
    
    func closeTabsToRight(of tab: TabsModel.Tab) {
        let tabsToClose = tabs.filter { $0.order > tab.order && $0.closable }
        tabsToClose.forEach { closeTab($0) }
    }
    
    // MARK: - Selection
    
    func selectTab(_ tab: TabsModel.Tab) {
        // Deactivate all tabs
        for index in tabs.indices {
            tabs[index].isActive = false
        }
        
        // Activate selected tab
        if let index = tabs.firstIndex(where: { $0.id == tab.id }) {
            tabs[index].isActive = true
            tabs[index].lastAccessedAt = Date()
            activeTab = tabs[index]
            updateTab(tabs[index])
        }
    }
    
    func selectNextTab() {
        guard let current = activeTab,
              let index = tabs.firstIndex(where: { $0.id == current.id }),
              index < tabs.count - 1 else {
            if let first = tabs.first {
                selectTab(first)
            }
            return
        }
        selectTab(tabs[index + 1])
    }
    
    func selectPreviousTab() {
        guard let current = activeTab,
              let index = tabs.firstIndex(where: { $0.id == current.id }),
              index > 0 else {
            if let last = tabs.last {
                selectTab(last)
            }
            return
        }
        selectTab(tabs[index - 1])
    }
    
    // MARK: - Reordering
    
    func moveTab(from sourceIndex: Int, to destinationIndex: Int) {
        guard model.allowsReordering else { return }
        
        var sortedTabs = tabs.sorted { $0.order < $1.order }
        let tab = sortedTabs.remove(at: sourceIndex)
        sortedTabs.insert(tab, at: destinationIndex)
        
        for (index, var tab) in sortedTabs.enumerated() {
            tab.order = index
            if let tabIndex = tabs.firstIndex(where: { $0.id == tab.id }) {
                tabs[tabIndex] = tab
            }
        }
    }
    
    func reorderTabs() {
        var pinned = pinnedTabs()
        var unpinned = unpinnedTabs()
        
        for (index, var tab) in pinned.enumerated() {
            tab.order = index
            if let tabIndex = tabs.firstIndex(where: { $0.id == tab.id }) {
                tabs[tabIndex] = tab
            }
        }
        
        let pinnedCount = pinned.count
        for (index, var tab) in unpinned.enumerated() {
            tab.order = pinnedCount + index
            if let tabIndex = tabs.firstIndex(where: { $0.id == tab.id }) {
                tabs[tabIndex] = tab
            }
        }
    }
    
    // MARK: - Data Source
    
    func setDataSource(_ dataSource: TabsDataSource) {
        self.dataSource = dataSource
        loadTabs()
    }
    
    func loadTabs() {
        guard let dataSource = dataSource else { return }
        tabs = dataSource.fetchTabs().sorted { $0.order < $1.order }
        activeTab = tabs.first { $0.isActive }
    }
}
