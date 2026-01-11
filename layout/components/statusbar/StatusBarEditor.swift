import Foundation

// MARK: - StatusBar Editor

@available(macOS 10.15, iOS 13.0, *)
struct StatusBarEditor {
    
    static func validateModel(_ model: StatusBarModel) -> [String] {
        var errors: [String] = []
        
        if model.height <= 0 {
            errors.append("Height must be greater than 0")
        }
        
        if model.updateInterval < 0 {
            errors.append("Update interval cannot be negative")
        }
        
        return errors
    }
    
    static func validateItem(_ item: StatusBarModel.StatusItem) -> [String] {
        var errors: [String] = []
        
        if item.text.isEmpty {
            errors.append("Text cannot be empty")
        }
        
        if item.order < 0 {
            errors.append("Order cannot be negative")
        }
        
        return errors
    }
    
    static func scaleModel(_ model: inout StatusBarModel, factor: Double) {
        model.height *= factor
    }
    
    static func resetToDefaults(_ model: inout StatusBarModel) {
        model = StatusBarModel.mock()
    }
    
    static func updateText(_ item: inout StatusBarModel.StatusItem, newText: String) {
        item.text = newText
        item.updatedAt = Date()
    }
    
    static func setIcon(_ item: inout StatusBarModel.StatusItem, icon: String?) {
        item.icon = icon
        item.updatedAt = Date()
    }
    
    static func batchSetVisibility(_ items: inout [StatusBarModel.StatusItem], isVisible: Bool) {
        for index in items.indices {
            items[index].isVisible = isVisible
            items[index].updatedAt = Date()
        }
    }
    
    static func sortByPosition(_ items: inout [StatusBarModel.StatusItem]) {
        items.sort { $0.position.rawValue < $1.position.rawValue }
    }
    
    static func cloneItem(_ item: StatusBarModel.StatusItem) -> StatusBarModel.StatusItem {
        StatusBarModel.StatusItem(
            position: item.position,
            icon: item.icon,
            text: "\(item.text) Copy",
            action: item.action,
            metadata: item.metadata,
            order: item.order + 1
        )
    }
}
