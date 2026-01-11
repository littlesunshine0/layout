import Foundation

// MARK: - Quick Start Examples

/// Example 1: Basic Setup with Mock Data
func example1_MockDataSetup() {
    let coordinator = LayoutCoordinator(useMockData: true)
    
    print("TitleBar height: \(coordinator.titleBar.model.height)")
    print("Navigation width: \(coordinator.navigation.model.width)")
    print("Active panels: \(coordinator.panel.model.activePanels.count)")
}

/// Example 2: Load from Property Files
func example2_PropertyFiles() {
    let coordinator = LayoutCoordinator(useMockData: false)
    
    // All properties loaded from files
    print("Properties loaded from: /layout/components/*/properties/")
}

/// Example 3: Interact with Components
func example3_ComponentInteraction() {
    let coordinator = LayoutCoordinator(useMockData: true)
    
    // Navigation
    coordinator.navigation.toggleExpansion()
    if let firstItem = coordinator.navigation.model.items.first {
        coordinator.navigation.select(firstItem)
    }
    
    // Panels
    coordinator.panel.openPanel(type: .terminal)
    coordinator.panel.openPanel(type: .chat)
    
    // Content
    if let item = coordinator.content.model.items.first {
        coordinator.content.select(item)
    }
    
    coordinator.content.toggleInspector()
}

/// Example 4: Update Properties
func example4_UpdateProperties() {
    let loader = PropertyLoader.shared
    
    do {
        // Save new values
        try loader.saveProperty(component: "titlebar", property: "TitleBarHeight", value: "60")
        try loader.saveProperty(component: "navigation", property: "NavigationWidth", value: "80")
        try loader.saveProperty(component: "panel", property: "PanelMaxCount", value: "5")
        
        // Reload
        let coordinator = LayoutCoordinator(useMockData: false)
        print("Updated titlebar height: \(coordinator.titleBar.model.height)")
        
    } catch {
        print("Error saving properties: \(error)")
    }
}

/// Example 5: Custom Data Sources (Future)
class MyTitleBarDataSource: TitleBarDataSource {
    var titlePublisher: AnyPublisher<String, Never> {
        Just("My Custom Title").eraseToAnyPublisher()
    }
    
    var iconPublisher: AnyPublisher<String, Never> {
        Just("star.fill").eraseToAnyPublisher()
    }
}

func example5_RealDataIntegration() {
    let coordinator = LayoutCoordinator(useMockData: true)
    
    // When ready to connect real data:
    let titleBarSource = MyTitleBarDataSource()
    // coordinator.titleBar.connectToRealData(titleBarSource)
    
    // Or connect all at once:
    // coordinator.connectToRealData(
    //     titleBarDataSource: myTitleBarSource,
    //     navigationDataSource: myNavSource,
    //     categoryDataSource: myCategorySource,
    //     panelDataSource: myPanelSource,
    //     contentDataSource: myContentSource
    // )
}

/// Example 6: Panel Management
func example6_PanelManagement() {
    let coordinator = LayoutCoordinator(useMockData: true)
    
    // Open panels
    coordinator.panel.openPanel(type: .terminal)
    coordinator.panel.openPanel(type: .chat)
    coordinator.panel.openPanel(type: .console)
    
    // Access active panels
    for panel in coordinator.panel.model.activePanels {
        print("Panel: \(panel.type.title) at \(panel.position)")
        
        // Move panel
        coordinator.panel.updatePanelPosition(panel, to: CGPoint(x: 200, y: 150))
        
        // Resize panel
        coordinator.panel.updatePanelSize(panel, to: CGSize(width: 500, height: 400))
        
        // Minimize
        coordinator.panel.toggleMinimize(panel)
    }
    
    // Close a panel
    if let firstPanel = coordinator.panel.model.activePanels.first {
        coordinator.panel.closePanel(firstPanel)
    }
}

/// Example 7: Category Filtering
func example7_CategoryFiltering() {
    let coordinator = LayoutCoordinator(useMockData: true)
    
    // Add categories
    coordinator.category.addCategory(name: "In Progress", icon: "clock")
    coordinator.category.addCategory(name: "Completed", icon: "checkmark.circle.fill")
    
    // Search
    coordinator.category.searchText = "recent"
    coordinator.category.filterCategories()
    
    print("Filtered categories: \(coordinator.category.filteredCategories.count)")
}

/// Example 8: Content Management
func example8_ContentManagement() {
    let coordinator = LayoutCoordinator(useMockData: true)
    
    // Create new items
    coordinator.content.createItem(title: "NewProject", type: .project)
    coordinator.content.createItem(title: "MyPackage", type: .package)
    
    // Search content
    coordinator.content.searchText = "todo"
    coordinator.content.filterItems()
    
    // Select and inspect
    if let item = coordinator.content.filteredItems.first {
        coordinator.content.select(item)
        // Inspector automatically shows
    }
    
    // Delete
    if let item = coordinator.content.model.items.first {
        coordinator.content.deleteItem(item)
    }
}

// MARK: - Run Examples

func runAllExamples() {
    print("=== Example 1: Mock Data Setup ===")
    example1_MockDataSetup()
    
    print("\n=== Example 2: Property Files ===")
    example2_PropertyFiles()
    
    print("\n=== Example 3: Component Interaction ===")
    example3_ComponentInteraction()
    
    print("\n=== Example 4: Update Properties ===")
    example4_UpdateProperties()
    
    print("\n=== Example 6: Panel Management ===")
    example6_PanelManagement()
    
    print("\n=== Example 7: Category Filtering ===")
    example7_CategoryFiltering()
    
    print("\n=== Example 8: Content Management ===")
    example8_ContentManagement()
}

// Uncomment to run:
// runAllExamples()
