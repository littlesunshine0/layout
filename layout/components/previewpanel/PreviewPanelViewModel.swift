import Foundation
import Combine

// MARK: - PreviewPanel DataSource Protocol

@available(macOS 10.15, iOS 13.0, *)
protocol PreviewPanelDataSource {
    func createItem(_ item: PreviewPanelModel.PreviewItem)
    func updateItem(_ item: PreviewPanelModel.PreviewItem)
    func deleteItem(_ item: PreviewPanelModel.PreviewItem)
    func fetchItems() -> [PreviewPanelModel.PreviewItem]
}

// MARK: - PreviewPanel ViewModel

@available(macOS 10.15, iOS 13.0, *)
final class PreviewPanelViewModel: ObservableObject {
    // Published Properties
    @Published var model: PreviewPanelModel
    @Published var items: [PreviewPanelModel.PreviewItem]
    @Published var selectedItem: PreviewPanelModel.PreviewItem?
    @Published var currentZoom: Double
    @Published var searchQuery: String = ""
    @Published var filterType: PreviewPanelModel.PreviewType?
    @Published var showFavoritesOnly: Bool = false
    @Published var sortOrder: SortOrder = .nameAscending
    
    // Zoom and Pan
    @Published var panOffset: (x: Double, y: Double) = (0, 0)
    @Published var isZooming: Bool = false
    @Published var isPanning: Bool = false
    
    // Editing State
    @Published var isEditing: Bool = false
    @Published var hasUnsavedChanges: Bool = false
    
    // Private
    private var dataSource: PreviewPanelDataSource?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Enums
    
    enum SortOrder {
        case nameAscending
        case nameDescending
        case dateAscending
        case dateDescending
        case sizeAscending
        case sizeDescending
        case typeGrouped
    }
    
    // MARK: - Initialization
    
    init(model: PreviewPanelModel = .mock(), items: [PreviewPanelModel.PreviewItem] = PreviewPanelModel.mockItems()) {
        self.model = model
        self.items = items
        self.currentZoom = model.defaultZoom
    }
    
    // MARK: - CRUD Operations
    
    // Create
    func createItem(
        name: String,
        type: PreviewPanelModel.PreviewType,
        filePath: String,
        fileSize: Int64 = 0,
        dimensions: (width: Int, height: Int)? = nil,
        duration: TimeInterval? = nil,
        metadata: [String: String] = [:],
        tags: [String] = []
    ) {
        let item = PreviewPanelModel.PreviewItem(
            name: name,
            type: type,
            filePath: filePath,
            fileSize: fileSize,
            dimensions: dimensions,
            duration: duration,
            metadata: metadata,
            tags: tags
        )
        
        if let dataSource = dataSource {
            dataSource.createItem(item)
        } else {
            items.append(item)
        }
    }
    
    // Read
    func getItem(byId id: String) -> PreviewPanelModel.PreviewItem? {
        items.first { $0.id == id }
    }
    
    func filteredItems() -> [PreviewPanelModel.PreviewItem] {
        var filtered = items
        
        // Filter by search query
        if !searchQuery.isEmpty {
            filtered = filtered.filter { item in
                item.name.localizedCaseInsensitiveContains(searchQuery) ||
                item.tags.contains { $0.localizedCaseInsensitiveContains(searchQuery) }
            }
        }
        
        // Filter by type
        if let filterType = filterType {
            filtered = filtered.filter { $0.type == filterType }
        }
        
        // Filter favorites
        if showFavoritesOnly {
            filtered = filtered.filter { $0.isFavorite }
        }
        
        // Sort
        return sortItems(filtered)
    }
    
    // Update
    func updateItem(_ item: PreviewPanelModel.PreviewItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            var updatedItem = item
            updatedItem.modifiedAt = Date()
            
            if let dataSource = dataSource {
                dataSource.updateItem(updatedItem)
            }
            
            items[index] = updatedItem
        }
    }
    
    func toggleFavorite(itemId: String) {
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            items[index].isFavorite.toggle()
            updateItem(items[index])
        }
    }
    
    func updateMetadata(itemId: String, metadata: [String: String]) {
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            items[index].metadata = metadata
            updateItem(items[index])
        }
    }
    
    func addTags(itemId: String, tags: [String]) {
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            items[index].tags.append(contentsOf: tags)
            updateItem(items[index])
        }
    }
    
    // Delete
    func deleteItem(_ item: PreviewPanelModel.PreviewItem) {
        if let dataSource = dataSource {
            dataSource.deleteItem(item)
        }
        
        items.removeAll { $0.id == item.id }
        
        if selectedItem?.id == item.id {
            selectedItem = nil
        }
    }
    
    func deleteItems(_ itemsToDelete: [PreviewPanelModel.PreviewItem]) {
        itemsToDelete.forEach { deleteItem($0) }
    }
    
    // MARK: - Zoom Operations
    
    func zoomIn() {
        let newZoom = min(currentZoom * 1.25, model.maxZoom)
        setZoom(newZoom)
    }
    
    func zoomOut() {
        let newZoom = max(currentZoom / 1.25, model.minZoom)
        setZoom(newZoom)
    }
    
    func setZoom(_ zoom: Double) {
        currentZoom = max(model.minZoom, min(zoom, model.maxZoom))
    }
    
    func resetZoom() {
        currentZoom = model.defaultZoom
        panOffset = (0, 0)
    }
    
    func fitToWindow() {
        // Calculate zoom to fit content in window
        currentZoom = 1.0 // Simplified
    }
    
    func actualSize() {
        currentZoom = 1.0
    }
    
    // MARK: - Pan Operations
    
    func pan(dx: Double, dy: Double) {
        panOffset.x += dx
        panOffset.y += dy
    }
    
    func resetPan() {
        panOffset = (0, 0)
    }
    
    // MARK: - Edit Operations
    
    func startEditing() {
        guard model.allowsEditing else { return }
        isEditing = true
    }
    
    func stopEditing(save: Bool = true) {
        isEditing = false
        if !save {
            hasUnsavedChanges = false
        }
    }
    
    func saveChanges() {
        guard let selectedItem = selectedItem else { return }
        updateItem(selectedItem)
        hasUnsavedChanges = false
    }
    
    func discardChanges() {
        hasUnsavedChanges = false
        isEditing = false
    }
    
    // MARK: - Export Operations
    
    func exportItem(_ item: PreviewPanelModel.PreviewItem, to destination: String) -> Bool {
        // Implementation would handle actual file export
        print("Exporting \(item.name) to \(destination)")
        return true
    }
    
    func exportItems(_ items: [PreviewPanelModel.PreviewItem], to destination: String) -> Bool {
        items.allSatisfy { exportItem($0, to: destination) }
    }
    
    // MARK: - Selection
    
    func selectItem(_ item: PreviewPanelModel.PreviewItem) {
        selectedItem = item
        resetZoom()
    }
    
    func selectNext() {
        guard let current = selectedItem,
              let index = items.firstIndex(where: { $0.id == current.id }),
              index < items.count - 1 else { return }
        selectedItem = items[index + 1]
    }
    
    func selectPrevious() {
        guard let current = selectedItem,
              let index = items.firstIndex(where: { $0.id == current.id }),
              index > 0 else { return }
        selectedItem = items[index - 1]
    }
    
    // MARK: - Sorting
    
    private func sortItems(_ items: [PreviewPanelModel.PreviewItem]) -> [PreviewPanelModel.PreviewItem] {
        switch sortOrder {
        case .nameAscending:
            return items.sorted { $0.name < $1.name }
        case .nameDescending:
            return items.sorted { $0.name > $1.name }
        case .dateAscending:
            return items.sorted { $0.modifiedAt < $1.modifiedAt }
        case .dateDescending:
            return items.sorted { $0.modifiedAt > $1.modifiedAt }
        case .sizeAscending:
            return items.sorted { $0.fileSize < $1.fileSize }
        case .sizeDescending:
            return items.sorted { $0.fileSize > $1.fileSize }
        case .typeGrouped:
            return items.sorted { $0.type.rawValue < $1.type.rawValue }
        }
    }
    
    // MARK: - Data Source
    
    func setDataSource(_ dataSource: PreviewPanelDataSource) {
        self.dataSource = dataSource
        loadItems()
    }
    
    func loadItems() {
        guard let dataSource = dataSource else { return }
        items = dataSource.fetchItems()
    }
}
