import Foundation

// MARK: - PathBar Generator

@available(macOS 10.15, iOS 13.0, *)
struct PathBarGenerator {
    
    static func generateDefault() -> PathBarModel {
        PathBarModel.mock()
    }
    
    static func generateCompact() -> PathBarModel {
        PathBarModel(
            height: 24,
            maxSegments: 4,
            backgroundColor: "#FAFAFA",
            font: "System-Tiny",
            textColor: "#666666",
            separator: "›",
            truncationMode: .middle,
            showsIcons: false,
            showsHome: true,
            clickableSegments: true
        )
    }
    
    static func generateBreadcrumb() -> PathBarModel {
        PathBarModel(
            height: 32,
            maxSegments: 10,
            backgroundColor: "#FFFFFF",
            font: "System",
            textColor: "#007AFF",
            separator: "›",
            truncationMode: .middle,
            showsIcons: true,
            showsHome: true,
            clickableSegments: true
        )
    }
    
    static func exportToJSON(model: PathBarModel) -> String {
        let dict: [String: Any] = [
            "height": model.height,
            "maxSegments": model.maxSegments,
            "backgroundColor": model.backgroundColor,
            "font": model.font,
            "textColor": model.textColor,
            "separator": model.separator,
            "truncationMode": model.truncationMode.rawValue,
            "showsIcons": model.showsIcons,
            "showsHome": model.showsHome,
            "clickableSegments": model.clickableSegments
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
              let json = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        
        return json
    }
    
    static func importFromJSON(_ json: String) -> PathBarModel? {
        guard let data = json.data(using: .utf8),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        
        return PathBarModel(
            height: dict["height"] as? Double ?? 28,
            maxSegments: dict["maxSegments"] as? Int ?? 8,
            backgroundColor: dict["backgroundColor"] as? String ?? "#F5F5F5",
            font: dict["font"] as? String ?? "System-Small",
            textColor: dict["textColor"] as? String ?? "#333333",
            separator: dict["separator"] as? String ?? "/",
            truncationMode: PathBarModel.TruncationMode(rawValue: dict["truncationMode"] as? String ?? "middle") ?? .middle,
            showsIcons: dict["showsIcons"] as? Bool ?? true,
            showsHome: dict["showsHome"] as? Bool ?? true,
            clickableSegments: dict["clickableSegments"] as? Bool ?? true
        )
    }
    
    static func exportSegmentsToCSV(_ segments: [PathBarModel.PathSegment]) -> String {
        var csv = "ID,Name,Path,Icon,IsClickable,Order\n"
        
        for segment in segments {
            csv += "\(segment.id),\(segment.name),\(segment.path),\(segment.icon ?? ""),\(segment.isClickable),\(segment.order)\n"
        }
        
        return csv
    }
    
    static func generatePathSegments(from pathString: String) -> [PathBarModel.PathSegment] {
        var segments: [PathBarModel.PathSegment] = []
        var components = pathString.components(separatedBy: "/").filter { !$0.isEmpty }
        
        if pathString.hasPrefix("/") {
            segments.append(PathBarModel.PathSegment(name: "/", path: "/", icon: "internaldrive", order: 0))
        } else if pathString.hasPrefix("~") {
            components.removeFirst()
            segments.append(PathBarModel.PathSegment(name: "~", path: NSHomeDirectory(), icon: "house.fill", order: 0))
        }
        
        var currentPath = pathString.hasPrefix("/") ? "" : NSHomeDirectory()
        for component in components {
            currentPath += "/\(component)"
            segments.append(PathBarModel.PathSegment(
                name: component,
                path: currentPath,
                icon: "folder.fill",
                order: segments.count
            ))
        }
        
        return segments
    }
}
