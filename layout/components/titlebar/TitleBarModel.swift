import Foundation

// MARK: - TitleBar Model

struct TitleBarModel {
    var height: CGFloat
    var backgroundColor: String
    var alignment: Alignment
    var showsTitle: Bool
    var showsIcon: Bool
    var iconSize: CGFloat
    var buttons: [TitleBarButton]
    var buttonsPosition: Alignment
    var dividerVisible: Bool
    
    enum Alignment: String {
        case leading, center, trailing
    }
    
    enum TitleBarButton: String, CaseIterable {
        case close, minimize, maximize, settings
        
        var icon: String {
            switch self {
            case .close: return "xmark"
            case .minimize: return "minus"
            case .maximize: return "arrow.up.left.and.arrow.down.right"
            case .settings: return "gearshape"
            }
        }
    }
    
    // Mock data factory
    static func mock() -> TitleBarModel {
        TitleBarModel(
            height: 52,
            backgroundColor: "#1C1C1E",
            alignment: .leading,
            showsTitle: true,
            showsIcon: true,
            iconSize: 24,
            buttons: [.close, .minimize, .maximize, .settings],
            buttonsPosition: .trailing,
            dividerVisible: true
        )
    }
    
    // Property file loader (integrates with real properties later)
    static func fromProperties(_ basePath: String) -> TitleBarModel {
        // TODO: Load from property files
        return mock()
    }
}
