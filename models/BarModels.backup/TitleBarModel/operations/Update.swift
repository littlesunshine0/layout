import Foundation

/// Update operation for TitleBar component
/// Handles modification of existing title bars
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarUpdate {
    
    /// Updates an existing title bar
    public static func execute(_ model: inout TitleBarModel, changes: [TitleBarField: Any]) {
        for (field, value) in changes {
            switch field {
            case .title:
                if let title = value as? String {
                    model.title = title
                }
            case .showsIcon:
                if let shows = value as? Bool {
                    model.showsIcon = shows
                }
            case .height:
                if let height = value as? Double {
                    model.height = height
                }
            case .backgroundColor:
                if let color = value as? String {
                    model.backgroundColor = color
                }
            }
        }
        model.updatedAt = Date()
    }
    
    public enum TitleBarField {
        case title
        case showsIcon
        case height
        case backgroundColor
    }
}
