import Foundation
import Combine

// MARK: - Category ViewModel

class CategoryViewModel: ObservableObject {
    @Published var model: CategoryModel
    @Published var selectedCategory: CategoryModel.Category?
    @Published var searchText: String = ""
    @Published var filteredCategories: [CategoryModel.Category]
    
    // Future integration point
    private var dataSource: CategoryDataSource?
    
    init(model: CategoryModel = .mock(), dataSource: CategoryDataSource? = nil) {
        self.model = model
        self.filteredCategories = model.categories
        self.dataSource = dataSource
        
        // Select first category by default
        self.selectedCategory = model.categories.first
    }
    
    // Search/filter
    func filterCategories() {
        if searchText.isEmpty {
            filteredCategories = model.categories
        } else {
            filteredCategories = model.categories.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // Select category
    func select(_ category: CategoryModel.Category) {
        selectedCategory = category
        print("Selected category: \(category.name)")
    }
    
    // Add new category
    func addCategory(name: String, icon: String) {
        let newCategory = CategoryModel.Category(name: name, icon: icon, count: 0)
        // TODO: Persist to real data
        print("Add category: \(name)")
    }
    
    // Future integration point
    func connectToRealData(_ dataSource: CategoryDataSource) {
        self.dataSource = dataSource
        // Subscribe to category updates
    }
}

// MARK: - Data Source Protocol

protocol CategoryDataSource {
    var categoriesPublisher: AnyPublisher<[CategoryModel.Category], Never> { get }
    func createCategory(name: String, icon: String) -> CategoryModel.Category
    func deleteCategory(id: UUID)
}
