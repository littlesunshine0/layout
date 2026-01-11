import Foundation

// MARK: - Panel Model

struct PanelModel {
    var maxCount: Int
    var floats: Bool
    var minWidth: CGFloat
    var minHeight: CGFloat
    var types: [PanelType]
    var cardCornerRadius: CGFloat
    var cardShadow: Bool
    var cardBackgroundColor: String
    var activePanels: [ActivePanel]
    
    enum PanelType: String, CaseIterable {
        case chat, notification, settings, terminal, console
        case workflow, agent, documentation, history, activity
        case analytics, inspector
        
        var icon: String {
            switch self {
            case .chat: return "bubble.left.and.bubble.right"
            case .notification: return "bell.fill"
            case .settings: return "gearshape"
            case .terminal: return "terminal"
            case .console: return "list.bullet.rectangle"
            case .workflow: return "arrow.triangle.branch"
            case .agent: return "person.crop.circle.badge.checkmark"
            case .documentation: return "doc.text"
            case .history: return "clock.arrow.circlepath"
            case .activity: return "chart.line.uptrend.xyaxis"
            case .analytics: return "chart.bar.fill"
            case .inspector: return "info.circle"
            }
        }
        
        var title: String {
            self.rawValue.capitalized
        }
    }
    
    struct ActivePanel: Identifiable {
        let id = UUID()
        let type: PanelType
        var position: CGPoint
        var size: CGSize
        var isMinimized: Bool
        
        init(type: PanelType, position: CGPoint = .zero, size: CGSize = CGSize(width: 400, height: 500), isMinimized: Bool = false) {
            self.type = type
            self.position = position
            self.size = size
            self.isMinimized = isMinimized
        }
    }
    
    // Mock data factory
    static func mock() -> PanelModel {
        PanelModel(
            maxCount: 3,
            floats: true,
            minWidth: 320,
            minHeight: 240,
            types: PanelType.allCases,
            cardCornerRadius: 12,
            cardShadow: true,
            cardBackgroundColor: "#1C1C1E",
            activePanels: [
                ActivePanel(type: .terminal, position: CGPoint(x: 100, y: 100)),
                ActivePanel(type: .chat, position: CGPoint(x: 550, y: 100))
            ]
        )
    }
    
    // Property file loader
    static func fromProperties(_ basePath: String) -> PanelModel {
        // TODO: Load from property files
        return mock()
    }
}
