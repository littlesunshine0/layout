import Foundation

// MARK: - PreviewPanel Generator

@available(macOS 10.15, iOS 13.0, *)
struct PreviewPanelGenerator {
    
    // MARK: - Template Generation
    
    static func generateDefault() -> PreviewPanelModel {
        PreviewPanelModel.mock()
    }
    
    static func generateCompact() -> PreviewPanelModel {
        PreviewPanelModel(
            width: 400,
            height: 300,
            contentPadding: 8,
            toolbarHeight: 32,
            backgroundColor: "#F5F5F5",
            showsToolbar: true,
            showsMetadata: false,
            showsZoomControls: false,
            minZoom: 0.5,
            maxZoom: 2.0,
            defaultZoom: 1.0,
            allowsEditing: false
        )
    }
    
    static func generateFullscreen() -> PreviewPanelModel {
        PreviewPanelModel(
            width: 1920,
            height: 1080,
            contentPadding: 24,
            toolbarHeight: 52,
            backgroundColor: "#000000",
            showsToolbar: false,
            showsMetadata: true,
            showsZoomControls: true,
            minZoom: 0.1,
            maxZoom: 10.0,
            defaultZoom: 1.0,
            allowsEditing: false
        )
    }
    
    static func generateEditor() -> PreviewPanelModel {
        PreviewPanelModel(
            width: 1200,
            height: 800,
            contentPadding: 20,
            toolbarHeight: 48,
            backgroundColor: "#FFFFFF",
            showsToolbar: true,
            showsMetadata: true,
            showsZoomControls: true,
            minZoom: 0.25,
            maxZoom: 8.0,
            defaultZoom: 1.0,
            allowsEditing: true
        )
    }
    
    // MARK: - Item Templates
    
    static func generateImageItem(name: String, path: String) -> PreviewPanelModel.PreviewItem {
        PreviewPanelModel.PreviewItem(
            name: name,
            type: .image,
            filePath: path,
            fileSize: 2_097_152,
            dimensions: (width: 1920, height: 1080),
            metadata: ["Format": "JPEG"],
            tags: ["image"]
        )
    }
    
    static func generateVideoItem(name: String, path: String) -> PreviewPanelModel.PreviewItem {
        PreviewPanelModel.PreviewItem(
            name: name,
            type: .video,
            filePath: path,
            fileSize: 52_428_800,
            duration: 300.0,
            dimensions: (width: 1920, height: 1080),
            metadata: ["Codec": "H.264", "FPS": "30"],
            tags: ["video"]
        )
    }
    
    static func generateDocumentItem(name: String, path: String) -> PreviewPanelModel.PreviewItem {
        PreviewPanelModel.PreviewItem(
            name: name,
            type: .document,
            filePath: path,
            fileSize: 1_048_576,
            metadata: ["Pages": "10"],
            tags: ["document"]
        )
    }
    
    // MARK: - JSON Export/Import
    
    static func exportToJSON(model: PreviewPanelModel) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let dict: [String: Any] = [
            "width": model.width,
            "height": model.height,
            "contentPadding": model.contentPadding,
            "toolbarHeight": model.toolbarHeight,
            "backgroundColor": model.backgroundColor,
            "showsToolbar": model.showsToolbar,
            "showsMetadata": model.showsMetadata,
            "showsZoomControls": model.showsZoomControls,
            "minZoom": model.minZoom,
            "maxZoom": model.maxZoom,
            "defaultZoom": model.defaultZoom,
            "allowsEditing": model.allowsEditing
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
              let json = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        
        return json
    }
    
    static func importFromJSON(_ json: String) -> PreviewPanelModel? {
        guard let data = json.data(using: .utf8),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        
        return PreviewPanelModel(
            width: dict["width"] as? Double ?? 800,
            height: dict["height"] as? Double ?? 600,
            contentPadding: dict["contentPadding"] as? Double ?? 16,
            toolbarHeight: dict["toolbarHeight"] as? Double ?? 44,
            backgroundColor: dict["backgroundColor"] as? String ?? "#FFFFFF",
            showsToolbar: dict["showsToolbar"] as? Bool ?? true,
            showsMetadata: dict["showsMetadata"] as? Bool ?? true,
            showsZoomControls: dict["showsZoomControls"] as? Bool ?? true,
            minZoom: dict["minZoom"] as? Double ?? 0.1,
            maxZoom: dict["maxZoom"] as? Double ?? 5.0,
            defaultZoom: dict["defaultZoom"] as? Double ?? 1.0,
            allowsEditing: dict["allowsEditing"] as? Bool ?? true
        )
    }
    
    // MARK: - CSV Export/Import
    
    static func exportItemsToCSV(_ items: [PreviewPanelModel.PreviewItem]) -> String {
        var csv = "ID,Name,Type,FilePath,FileSize,CreatedAt,Tags\n"
        
        for item in items {
            let tags = item.tags.joined(separator: ";")
            csv += "\(item.id),\(item.name),\(item.type.rawValue),\(item.filePath),\(item.fileSize),\(item.createdAt),\(tags)\n"
        }
        
        return csv
    }
    
    static func importItemsFromCSV(_ csv: String) -> [PreviewPanelModel.PreviewItem] {
        let lines = csv.components(separatedBy: "\n").dropFirst()
        var items: [PreviewPanelModel.PreviewItem] = []
        
        for line in lines {
            let columns = line.components(separatedBy: ",")
            guard columns.count >= 6 else { continue }
            
            let typeRaw = columns[2]
            guard let type = PreviewPanelModel.PreviewType(rawValue: typeRaw) else { continue }
            
            let tags = columns.count > 6 ? columns[6].components(separatedBy: ";") : []
            
            let item = PreviewPanelModel.PreviewItem(
                id: columns[0],
                name: columns[1],
                type: type,
                filePath: columns[3],
                fileSize: Int64(columns[4]) ?? 0,
                tags: tags
            )
            items.append(item)
        }
        
        return items
    }
    
    // MARK: - Batch Generation
    
    static func generateBatchItems(count: Int, type: PreviewPanelModel.PreviewType) -> [PreviewPanelModel.PreviewItem] {
        (0..<count).map { index in
            PreviewPanelModel.PreviewItem(
                name: "\(type.rawValue)_\(index + 1)",
                type: type,
                filePath: "/path/to/\(type.rawValue)_\(index + 1)",
                fileSize: Int64.random(in: 1024...10_485_760),
                tags: [type.rawValue, "batch"]
            )
        }
    }
}
