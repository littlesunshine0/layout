import Foundation
import Combine

// MARK: - Main Layout Coordinator
// Orchestrates all UI components and manages state

class LayoutCoordinator: ObservableObject {
    
    // Component ViewModels
    @Published var titleBar: TitleBarViewModel
    @Published var navigation: NavigationViewModel
    @Published var category: CategoryViewModel
    @Published var panel: PanelViewModel
    @Published var content: ContentViewModel
    
    // Global state
    @Published var isFullScreen: Bool = false
    @Published var theme: LayoutTheme = .dark
    
    // Future: Real data sources
    private var cancellables = Set<AnyCancellable>()
    
    init(useMockData: Bool = true) {
        if useMockData {
            // Use mock data for UI development
            self.titleBar = TitleBarViewModel(model: .mock())
            self.navigation = NavigationViewModel(model: .mock())
            self.category = CategoryViewModel(model: .mock())
            self.panel = PanelViewModel(model: .mock())
            self.content = ContentViewModel(model: .mock())
        } else {
            // Load from property files
            self.titleBar = TitleBarViewModel(model: DataIntegration.loadTitleBarModel())
            self.navigation = NavigationViewModel(model: DataIntegration.loadNavigationModel())
            self.category = CategoryViewModel(model: DataIntegration.loadCategoryModel())
            self.panel = PanelViewModel(model: DataIntegration.loadPanelModel())
            self.content = ContentViewModel(model: DataIntegration.loadContentModel())
        }
        
        setupBindings()
    }
    
    // MARK: - Setup
    
    private func setupBindings() {
        // Navigation -> Content synchronization
        navigation.$selectedItem
            .sink { [weak self] item in
                guard let item = item else { return }
                self?.handleNavigationSelection(item)
            }
            .store(in: &cancellables)
        
        // Category -> Content synchronization
        category.$selectedCategory
            .sink { [weak self] category in
                guard let category = category else { return }
                self?.handleCategorySelection(category)
            }
            .store(in: &cancellables)
        
        // Content selection -> Inspector visibility
        content.$selectedItem
            .sink { [weak self] item in
                self?.content.model.showsInspector = (item != nil)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Navigation
    
    private func handleNavigationSelection(_ item: NavigationModel.NavigationItem) {
        print("Navigation selected: \(item.name)")
        
        switch item.name {
        case "chat":
            panel.openPanel(type: .chat)
        case "terminal":
            panel.openPanel(type: .terminal)
        case "settings":
            panel.openPanel(type: .settings)
        default:
            break
        }
    }
    
    private func handleCategorySelection(_ category: CategoryModel.Category) {
        print("Category selected: \(category.name)")
        // TODO: Filter content based on category
    }
    
    // MARK: - Integration with Real Data
    
    /// Call this when ready to connect to real data sources
    func connectToRealData(
        titleBarDataSource: TitleBarDataSource,
        navigationDataSource: NavigationDataSource,
        categoryDataSource: CategoryDataSource,
        panelDataSource: PanelDataSource,
        contentDataSource: ContentDataSource
    ) {
        titleBar.connectToRealData(titleBarDataSource)
        navigation.connectToRealData(navigationDataSource)
        category.connectToRealData(categoryDataSource)
        panel.connectToRealData(panelDataSource)
        content.connectToRealData(contentDataSource)
    }
}

// MARK: - Theme

enum LayoutTheme {
    case dark, light
    
    var backgroundColor: String {
        switch self {
        case .dark: return "#000000"
        case .light: return "#FFFFFF"
        }
    }
}
