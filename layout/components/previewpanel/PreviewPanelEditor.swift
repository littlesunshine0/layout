import Foundation

// MARK: - PreviewPanel Editor

@available(macOS 10.15, iOS 13.0, *)
struct PreviewPanelEditor {
    
    // MARK: - Validation
    
    static func validateModel(_ model: PreviewPanelModel) -> [String] {
        var errors: [String] = []
        
        if model.width <= 0 {
            errors.append("Width must be greater than 0")
        }
        
        if model.height <= 0 {
            errors.append("Height must be greater than 0")
        }
        
        if model.contentPadding < 0 {
            errors.append("Content padding cannot be negative")
        }
        
        if model.toolbarHeight < 0 {
            errors.append("Toolbar height cannot be negative")
        }
        
        if model.minZoom <= 0 || model.minZoom > model.maxZoom {
            errors.append("Invalid zoom range")
        }
        
        if model.defaultZoom < model.minZoom || model.defaultZoom > model.maxZoom {
            errors.append("Default zoom must be within min/max range")
        }
        
        return errors
    }
    
    static func validateItem(_ item: PreviewPanelModel.PreviewItem) -> [String] {
        var errors: [String] = []
        
        if item.name.isEmpty {
            errors.append("Name cannot be empty")
        }
        
        if item.filePath.isEmpty {
            errors.append("File path cannot be empty")
        }
        
        if item.fileSize < 0 {
            errors.append("File size cannot be negative")
        }
        
        if let dimensions = item.dimensions {
            if dimensions.width <= 0 || dimensions.height <= 0 {
                errors.append("Invalid dimensions")
            }
        }
        
        if let duration = item.duration {
            if duration < 0 {
                errors.append("Duration cannot be negative")
            }
        }
        
        return errors
    }
    
    // MARK: - Transformations
    
    static func scaleModel(_ model: inout PreviewPanelModel, factor: Double) {
        model.width *= factor
        model.height *= factor
        model.contentPadding *= factor
        model.toolbarHeight *= factor
    }
    
    static func adjustZoomRange(_ model: inout PreviewPanelModel, min: Double, max: Double) {
        model.minZoom = min
        model.maxZoom = max
        model.defaultZoom = max(min, min(model.defaultZoom, max))
    }
    
    static func setDimensions(_ model: inout PreviewPanelModel, width: Double, height: Double) {
        model.width = max(0, width)
        model.height = max(0, height)
    }
    
    static func resetToDefaults(_ model: inout PreviewPanelModel) {
        let defaults = PreviewPanelModel.mock()
        model = defaults
    }
    
    // MARK: - Item Transformations
    
    static func renameItem(_ item: inout PreviewPanelModel.PreviewItem, newName: String) {
        item.name = newName
        item.modifiedAt = Date()
    }
    
    static func updateFilePath(_ item: inout PreviewPanelModel.PreviewItem, newPath: String) {
        item.filePath = newPath
        item.modifiedAt = Date()
    }
    
    static func addMetadata(_ item: inout PreviewPanelModel.PreviewItem, key: String, value: String) {
        item.metadata[key] = value
        item.modifiedAt = Date()
    }
    
    static func removeMetadata(_ item: inout PreviewPanelModel.PreviewItem, key: String) {
        item.metadata.removeValue(forKey: key)
        item.modifiedAt = Date()
    }
    
    // MARK: - Batch Operations
    
    static func batchUpdateTags(_ items: inout [PreviewPanelModel.PreviewItem], tags: [String]) {
        for index in items.indices {
            items[index].tags = tags
            items[index].modifiedAt = Date()
        }
    }
    
    static func batchAddTag(_ items: inout [PreviewPanelModel.PreviewItem], tag: String) {
        for index in items.indices {
            if !items[index].tags.contains(tag) {
                items[index].tags.append(tag)
                items[index].modifiedAt = Date()
            }
        }
    }
    
    static func batchRemoveTag(_ items: inout [PreviewPanelModel.PreviewItem], tag: String) {
        for index in items.indices {
            items[index].tags.removeAll { $0 == tag }
            items[index].modifiedAt = Date()
        }
    }
    
    static func batchSetFavorite(_ items: inout [PreviewPanelModel.PreviewItem], isFavorite: Bool) {
        for index in items.indices {
            items[index].isFavorite = isFavorite
            items[index].modifiedAt = Date()
        }
    }
    
    // MARK: - Filtering Operations
    
    static func filterByType(_ items: [PreviewPanelModel.PreviewItem], type: PreviewPanelModel.PreviewType) -> [PreviewPanelModel.PreviewItem] {
        items.filter { $0.type == type }
    }
    
    static func filterByTags(_ items: [PreviewPanelModel.PreviewItem], tags: [String]) -> [PreviewPanelModel.PreviewItem] {
        items.filter { item in
            !Set(item.tags).isDisjoint(with: Set(tags))
        }
    }
    
    static func filterBySize(_ items: [PreviewPanelModel.PreviewItem], minSize: Int64, maxSize: Int64) -> [PreviewPanelModel.PreviewItem] {
        items.filter { $0.fileSize >= minSize && $0.fileSize <= maxSize }
    }
    
    static func filterByDateRange(_ items: [PreviewPanelModel.PreviewItem], startDate: Date, endDate: Date) -> [PreviewPanelModel.PreviewItem] {
        items.filter { $0.modifiedAt >= startDate && $0.modifiedAt <= endDate }
    }
    
    // MARK: - Merge Operations
    
    static func mergeMetadata(_ target: inout PreviewPanelModel.PreviewItem, from source: PreviewPanelModel.PreviewItem) {
        target.metadata.merge(source.metadata) { (_, new) in new }
        target.modifiedAt = Date()
    }
    
    static func mergeTags(_ target: inout PreviewPanelModel.PreviewItem, from source: PreviewPanelModel.PreviewItem) {
        let uniqueTags = Set(target.tags + source.tags)
        target.tags = Array(uniqueTags)
        target.modifiedAt = Date()
    }
    
    // MARK: - Clone Operations
    
    static func cloneModel(_ model: PreviewPanelModel) -> PreviewPanelModel {
        model
    }
    
    static func cloneItem(_ item: PreviewPanelModel.PreviewItem) -> PreviewPanelModel.PreviewItem {
        PreviewPanelModel.PreviewItem(
            name: "\(item.name) Copy",
            type: item.type,
            filePath: item.filePath,
            fileSize: item.fileSize,
            dimensions: item.dimensions,
            duration: item.duration,
            metadata: item.metadata,
            thumbnailPath: item.thumbnailPath,
            tags: item.tags,
            isFavorite: item.isFavorite
        )
    }
}
