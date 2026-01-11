import Foundation
import Combine

// MARK: - Navigation ViewModel

class NavigationViewModel: ObservableObject {
    @Published var model: NavigationModel
    @Published var selectedItem: NavigationModel.NavigationItem?
    @Published var hoveredItem: NavigationModel.NavigationItem?
    
    // Future integration point
    private var dataSource: NavigationDataSource?
    
    init(model: NavigationModel = .mock(), dataSource: NavigationDataSource? = nil) {
        self.model = model
        self.dataSource = dataSource
        
        // Select first item by default
        self.selectedItem = model.items.first
    }
    
    // Toggle expansion
    func toggleExpansion() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            model.isExpanded.toggle()
            model.showLabels = model.isExpanded
        }
    }
    
    // Select item
    func select(_ item: NavigationModel.NavigationItem) {
        selectedItem = item
        print("Selected navigation item: \(item.name)")
    }
    
    // Hover effects
    func setHoveredItem(_ item: NavigationModel.NavigationItem?) {
        hoveredItem = item
    }
    
    // Clear badge
    func clearBadge(for item: NavigationModel.NavigationItem) {
        // TODO: Update badge count in real data
    }
    
    // Future integration point
    func connectToRealData(_ dataSource: NavigationDataSource) {
        self.dataSource = dataSource
        // Subscribe to navigation updates
    }
}

// MARK: - Data Source Protocol

protocol NavigationDataSource {
    var itemsPublisher: AnyPublisher<[NavigationModel.NavigationItem], Never> { get }
    func updateBadge(for item: String, count: Int)
}
