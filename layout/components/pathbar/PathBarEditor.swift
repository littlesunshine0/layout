import Foundation

// MARK: - PathBar Editor

@available(macOS 10.15, iOS 13.0, *)
struct PathBarEditor {
    
    static func validateModel(_ model: PathBarModel) -> [String] {
        var errors: [String] = []
        
        if model.height <= 0 {
            errors.append("Height must be greater than 0")
        }
        
        if model.maxSegments <= 0 {
            errors.append("Max segments must be greater than 0")
        }
        
        return errors
    }
    
    static func validateSegment(_ segment: PathBarModel.PathSegment) -> [String] {
        var errors: [String] = []
        
        if segment.name.isEmpty {
            errors.append("Name cannot be empty")
        }
        
        if segment.path.isEmpty {
            errors.append("Path cannot be empty")
        }
        
        if segment.order < 0 {
            errors.append("Order cannot be negative")
        }
        
        return errors
    }
    
    static func scaleModel(_ model: inout PathBarModel, factor: Double) {
        model.height *= factor
    }
    
    static func setTruncationMode(_ model: inout PathBarModel, mode: PathBarModel.TruncationMode) {
        model.truncationMode = mode
    }
    
    static func resetToDefaults(_ model: inout PathBarModel) {
        model = PathBarModel.mock()
    }
    
    static func renameSegment(_ segment: inout PathBarModel.PathSegment, newName: String) {
        segment.name = newName
    }
    
    static func setIcon(_ segment: inout PathBarModel.PathSegment, icon: String?) {
        segment.icon = icon
    }
    
    static func toggleClickable(_ segment: inout PathBarModel.PathSegment) {
        segment.isClickable.toggle()
    }
    
    static func batchSetClickable(_ segments: inout [PathBarModel.PathSegment], isClickable: Bool) {
        for index in segments.indices {
            segments[index].isClickable = isClickable
        }
    }
    
    static func sortByOrder(_ segments: inout [PathBarModel.PathSegment]) {
        segments.sort { $0.order < $1.order }
    }
    
    static func cloneSegment(_ segment: PathBarModel.PathSegment) -> PathBarModel.PathSegment {
        PathBarModel.PathSegment(
            name: "\(segment.name) Copy",
            path: "\(segment.path)_copy",
            icon: segment.icon,
            isClickable: segment.isClickable,
            metadata: segment.metadata,
            order: segment.order + 1
        )
    }
}
