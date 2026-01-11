import Foundation
import Combine

// MARK: - StatusBar DataSource Protocol

@available(macOS 10.15, iOS 13.0, *)
protocol StatusBarDataSource {
    func createItem(_ item: StatusBarModel.StatusItem)
    func updateItem(_ item: StatusBarModel.StatusItem)
    func deleteItem(_ item: StatusBarModel.StatusItem)
    func fetchItems() -> [StatusBarModel.StatusItem]
}

// MARK: - StatusBar ViewModel

@available(macOS 10.15, iOS 13.0, *)
final class StatusBarViewModel: ObservableObject {
    // Published Properties
    @Published var model: StatusBarModel
    @Published var items: [StatusBarModel.StatusItem]
    @Published var progress: Double = 0.0
    @Published var isUpdating: Bool = false
    
    // Private
    private var dataSource: StatusBarDataSource?
    private var cancellables = Set<AnyCancellable>()
    private var updateTimer: Timer?
    
    // MARK: - Initialization
    
    init(model: StatusBarModel = .mock(), items: [StatusBarModel.StatusItem] = StatusBarModel.mockItems()) {
        self.model = model
        self.items = items
        startAutoUpdate()
    }
    
    // MARK: - CRUD Operations
    
    func createItem(position: StatusBarModel.StatusPosition, icon: String? = nil, text: String, action: String? = nil) {
        let newOrder = itemsForPosition(position).count
        let item = StatusBarModel.StatusItem(
            position: position,
            icon: icon,
            text: text,
            action: action,
            order: newOrder
        )
        
        if let dataSource = dataSource {
            dataSource.createItem(item)
        } else {
            items.append(item)
        }
    }
    
    func getItem(byId id: String) -> StatusBarModel.StatusItem? {
        items.first { $0.id == id }
    }
    
    func updateItem(_ item: StatusBarModel.StatusItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            var updatedItem = item
            updatedItem.updatedAt = Date()
            
            if let dataSource = dataSource {
                dataSource.updateItem(updatedItem)
            }
            
            items[index] = updatedItem
        }
    }
    
    func updateText(itemId: String, newText: String) {
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            items[index].text = newText
            updateItem(items[index])
        }
    }
    
    func toggleVisibility(itemId: String) {
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            items[index].isVisible.toggle()
            updateItem(items[index])
        }
    }
    
    func deleteItem(_ item: StatusBarModel.StatusItem) {
        if let dataSource = dataSource {
            dataSource.deleteItem(item)
        }
        items.removeAll { $0.id == item.id }
    }
    
    // MARK: - Position Helpers
    
    func itemsForPosition(_ position: StatusBarModel.StatusPosition) -> [StatusBarModel.StatusItem] {
        items.filter { $0.position == position && $0.isVisible }.sorted { $0.order < $1.order }
    }
    
    func leadingItems() -> [StatusBarModel.StatusItem] {
        itemsForPosition(.leading)
    }
    
    func centerItems() -> [StatusBarModel.StatusItem] {
        itemsForPosition(.center)
    }
    
    func trailingItems() -> [StatusBarModel.StatusItem] {
        itemsForPosition(.trailing)
    }
    
    // MARK: - Progress
    
    func setProgress(_ value: Double) {
        progress = max(0, min(1, value))
    }
    
    func incrementProgress(_ amount: Double) {
        setProgress(progress + amount)
    }
    
    func resetProgress() {
        progress = 0.0
    }
    
    // MARK: - Auto Update
    
    func startAutoUpdate() {
        updateTimer?.invalidate()
        updateTimer = Timer.scheduledTimer(withTimeInterval: model.updateInterval, repeats: true) { [weak self] _ in
            self?.performAutoUpdate()
        }
    }
    
    func stopAutoUpdate() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    private func performAutoUpdate() {
        // Update time and other dynamic items
        if let timeIndex = items.firstIndex(where: { $0.icon == "clock" }) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            items[timeIndex].text = formatter.string(from: Date())
        }
    }
    
    // MARK: - Data Source
    
    func setDataSource(_ dataSource: StatusBarDataSource) {
        self.dataSource = dataSource
        loadItems()
    }
    
    func loadItems() {
        guard let dataSource = dataSource else { return }
        items = dataSource.fetchItems()
    }
    
    deinit {
        stopAutoUpdate()
    }
}
