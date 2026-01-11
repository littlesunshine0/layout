import Foundation

// MARK: - StatusBar Generator

@available(macOS 10.15, iOS 13.0, *)
struct StatusBarGenerator {
    
    static func generateDefault() -> StatusBarModel {
        StatusBarModel.mock()
    }
    
    static func generateMinimal() -> StatusBarModel {
        StatusBarModel(
            height: 20,
            updateInterval: 5.0,
            backgroundColor: "#FAFAFA",
            font: "System-Tiny",
            textColor: "#666666",
            progressColor: "#999999",
            separator: "",
            animation: "none",
            showsLeft: true,
            showsCenter: false,
            showsRight: true,
            showsProgress: false
        )
    }
    
    static func generateDark() -> StatusBarModel {
        StatusBarModel(
            height: 24,
            updateInterval: 1.0,
            backgroundColor: "#2D2D2D",
            font: "System-Small",
            textColor: "#E0E0E0",
            progressColor: "#007AFF",
            separator: "•",
            animation: "slide",
            showsLeft: true,
            showsCenter: true,
            showsRight: true,
            showsProgress: true
        )
    }
    
    static func exportToJSON(model: StatusBarModel) -> String {
        let dict: [String: Any] = [
            "height": model.height,
            "updateInterval": model.updateInterval,
            "backgroundColor": model.backgroundColor,
            "font": model.font,
            "textColor": model.textColor,
            "progressColor": model.progressColor,
            "separator": model.separator,
            "animation": model.animation,
            "showsLeft": model.showsLeft,
            "showsCenter": model.showsCenter,
            "showsRight": model.showsRight,
            "showsProgress": model.showsProgress
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
              let json = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        
        return json
    }
    
    static func importFromJSON(_ json: String) -> StatusBarModel? {
        guard let data = json.data(using: .utf8),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        
        return StatusBarModel(
            height: dict["height"] as? Double ?? 24,
            updateInterval: dict["updateInterval"] as? TimeInterval ?? 1.0,
            backgroundColor: dict["backgroundColor"] as? String ?? "#F0F0F0",
            font: dict["font"] as? String ?? "System-Small",
            textColor: dict["textColor"] as? String ?? "#333333",
            progressColor: dict["progressColor"] as? String ?? "#007AFF",
            separator: dict["separator"] as? String ?? "|",
            animation: dict["animation"] as? String ?? "fade",
            showsLeft: dict["showsLeft"] as? Bool ?? true,
            showsCenter: dict["showsCenter"] as? Bool ?? true,
            showsRight: dict["showsRight"] as? Bool ?? true,
            showsProgress: dict["showsProgress"] as? Bool ?? true
        )
    }
    
    static func exportItemsToCSV(_ items: [StatusBarModel.StatusItem]) -> String {
        var csv = "ID,Position,Icon,Text,Action,IsVisible,Order\n"
        
        for item in items {
            csv += "\(item.id),\(item.position.rawValue),\(item.icon ?? ""),\(item.text),\(item.action ?? ""),\(item.isVisible),\(item.order)\n"
        }
        
        return csv
    }
}
