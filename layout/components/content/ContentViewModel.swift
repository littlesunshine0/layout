import Foundation
import Combine

// MARK: - Content ViewModel

class ContentViewModel: ObservableObject {
    @Published var model: ContentModel
    @Published var selectedItem: ContentModel.ContentItem? {
        didSet {
            model.showsInspector = (selectedItem != nil)
        }
    }
    @Published var searchText: String = ""
    @Published var filteredItems: [ContentModel.ContentItem]
    
    // Future integration point
    private var dataSource: ContentDataSource?
    
    init(model: ContentModel = .mock(), dataSource: ContentDataSource? = nil) {
        self.model = model
        self.filteredItems = model.items
        self.dataSource = dataSource
    }
    
    // Search/filter
    func filterItems() {
        if searchText.isEmpty {
            filteredItems = model.items
        } else {
            filteredItems = model.items.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                ($0.subtitle?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
    
    // Select item
    func select(_ item: ContentModel.ContentItem) {
        selectedItem = item
        print("Selected item: \(item.title)")
    }
    
    // Deselect
    func deselectItem() {
        selectedItem = nil
    }
    
    // Toggle inspector
    func toggleInspector() {
        model.showsInspector.toggle()
    }
    
    // Create new item
    func createItem(title: String, type: ContentModel.ContentItem.ItemType) {
        let newItem = ContentModel.ContentItem(
            title: title,
            subtitle: "New \(type.rawValue)",
            icon: iconForType(type),
            type: type
        )
        // TODO: Persist to real data
        print("Create item: \(title)")
    }
    
    // Delete item
    func deleteItem(_ item: ContentModel.ContentItem) {
        // TODO: Delete from real data
        print("Delete item: \(item.title)")
    }
    
    // Helper
    private func iconForType(_ type: ContentModel.ContentItem.ItemType) -> String {
        switch type {
        case .project: return "folder.fill"
        case .package: return "cube.box.fill"
        case .file: return "doc.fill"
        case .folder: return "folder"
        }
    }
    
    // Future integration point
    func connectToRealData(_ dataSource: ContentDataSource) {
        self.dataSource = dataSource
        // Subscribe to content updates
    }
}

// MARK: - Data Source Protocol

protocol ContentDataSource {
    var itemsPublisher: AnyPublisher<[ContentModel.ContentItem], Never> { get }
    func createItem(title: String, type: ContentModel.ContentItem.ItemType) -> ContentModel.ContentItem
    func deleteItem(id: UUID)
    func updateItem(id: UUID, updates: [String: Any])
}
