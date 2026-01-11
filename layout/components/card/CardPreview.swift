import Foundation

// MARK: - Card Preview

@available(macOS 10.15, iOS 13.0, *)
struct CardPreview {
    
    // MARK: - Preview Data
    
    struct PreviewConfiguration {
        let model: CardModel
        let cards: [CardModel.Card]
        let layout: CardModel.CardLayout
        let columns: Int
        let spacing: Double
        let showActions: Bool
        let enableHover: Bool
        let enableSelection: Bool
    }
    
    // MARK: - Default Previews
    
    /// Single card preview
    static func singleCard() -> PreviewConfiguration {
        PreviewConfiguration(
            model: .mock(),
            cards: [CardModel.mockCards()[0]],
            layout: .vertical,
            columns: 1,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Grid preview
    static func grid() -> PreviewConfiguration {
        PreviewConfiguration(
            model: .mock(),
            cards: CardModel.mockCards(),
            layout: .grid,
            columns: 3,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// List preview
    static func list() -> PreviewConfiguration {
        PreviewConfiguration(
            model: .mock(),
            cards: CardModel.mockCards(),
            layout: .list,
            columns: 1,
            spacing: 8,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Horizontal scroll preview
    static func horizontalScroll() -> PreviewConfiguration {
        PreviewConfiguration(
            model: .mock(),
            cards: CardModel.mockCards(),
            layout: .horizontal,
            columns: 1,
            spacing: 12,
            showActions: false,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Large cards
    static func largeCards() -> PreviewConfiguration {
        var model = CardModel.mock()
        model.width = 400
        model.height = 480
        model.imageHeight = 240
        
        return PreviewConfiguration(
            model: model,
            cards: CardModel.mockCards(),
            layout: .vertical,
            columns: 2,
            spacing: 24,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Compact cards
    static func compactCards() -> PreviewConfiguration {
        var model = CardModel.mock()
        model.width = 200
        model.height = 240
        model.imageHeight = 120
        model.padding = 12
        
        return PreviewConfiguration(
            model: model,
            cards: CardModel.mockCards(),
            layout: .grid,
            columns: 4,
            spacing: 8,
            showActions: false,
            enableHover: true,
            enableSelection: true
        )
    }
    
    // MARK: - Theme Previews
    
    /// Dark theme
    static func darkTheme() -> PreviewConfiguration {
        var model = CardModel.mock()
        model.backgroundColor = "#1C1C1E"
        model.borderColor = "#2C2C2E"
        model.shadowColor = "#000000"
        
        return PreviewConfiguration(
            model: model,
            cards: CardModel.mockCards(),
            layout: .grid,
            columns: 3,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Light theme
    static func lightTheme() -> PreviewConfiguration {
        var model = CardModel.mock()
        model.backgroundColor = "#FFFFFF"
        model.borderColor = "#E5E5EA"
        model.shadowColor = "#000000"
        model.shadowOpacity = 0.1
        
        return PreviewConfiguration(
            model: model,
            cards: CardModel.mockCards(),
            layout: .grid,
            columns: 3,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Colorful theme
    static func colorfulTheme() -> PreviewConfiguration {
        var cards = CardModel.mockCards()
        
        // Add different background colors
        var card1 = cards[0]
        card1.metadata["backgroundColor"] = "#FF3B30"
        
        var card2 = cards[1]
        card2.metadata["backgroundColor"] = "#007AFF"
        
        var card3 = cards[2]
        card3.metadata["backgroundColor"] = "#34C759"
        
        return PreviewConfiguration(
            model: .mock(),
            cards: [card1, card2, card3],
            layout: .grid,
            columns: 3,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    // MARK: - State Previews
    
    /// Hover state
    static func hoverState() -> PreviewConfiguration {
        var model = CardModel.mock()
        model.hoverEnabled = true
        model.hoverScale = 1.08
        
        return PreviewConfiguration(
            model: model,
            cards: [CardModel.mockCards()[0]],
            layout: .vertical,
            columns: 1,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Selected state
    static func selectedState() -> PreviewConfiguration {
        var cards = CardModel.mockCards()
        cards[0].metadata["isSelected"] = "true"
        
        return PreviewConfiguration(
            model: .mock(),
            cards: cards,
            layout: .grid,
            columns: 3,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Favorite state
    static func favoriteState() -> PreviewConfiguration {
        var cards = CardModel.mockCards()
        cards[0].isFavorite = true
        
        return PreviewConfiguration(
            model: .mock(),
            cards: cards,
            layout: .grid,
            columns: 3,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Archived state
    static func archivedState() -> PreviewConfiguration {
        var cards = CardModel.mockCards()
        cards[0].isArchived = true
        cards[0].metadata["opacity"] = "0.5"
        
        return PreviewConfiguration(
            model: .mock(),
            cards: cards,
            layout: .grid,
            columns: 3,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    // MARK: - FlowKit Previews
    
    /// FlowKit packages
    static func flowKitPackages() -> PreviewConfiguration {
        let packages = [
            "IdeaKit", "AppIdeaKit", "ProjectScaffold", 
            "IconKit", "ChatKit", "CommandKit",
            "WorkflowKit", "AnalyticsKit", "ThemeKit"
        ]
        
        let cards = CardGenerator.generateFlowKitCards(packages: packages)
        
        return PreviewConfiguration(
            model: .mock(),
            cards: cards,
            layout: .grid,
            columns: 3,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    /// Project cards
    static func projectCards() -> PreviewConfiguration {
        let projects = ["LayoutSystem", "FlowKit", "ProjectCreator"]
        let cards = CardGenerator.generateProjectCards(projects: projects)
        
        return PreviewConfiguration(
            model: .mock(),
            cards: cards,
            layout: .grid,
            columns: 3,
            spacing: 16,
            showActions: true,
            enableHover: true,
            enableSelection: true
        )
    }
    
    // MARK: - Export Preview
    
    /// Generate HTML preview
    static func generateHTML(_ config: PreviewConfiguration) -> String {
        var html = """
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                body { background: #000; font-family: -apple-system, sans-serif; padding: 20px; }
                .grid { display: grid; grid-template-columns: repeat(\(config.columns), 1fr); gap: \(config.spacing)px; }
                .card {
                    width: \(config.model.width)px;
                    height: \(config.model.height)px;
                    background: \(config.model.backgroundColor);
                    border: \(config.model.borderWidth)px solid \(config.model.borderColor);
                    border-radius: \(config.model.cornerRadius)px;
                    padding: \(config.model.padding)px;
                    box-shadow: 0 \(config.model.shadowRadius)px \(config.model.shadowRadius * 2)px \(config.model.shadowColor)33;
                }
                .card:hover { transform: scale(\(config.model.hoverScale)); transition: transform 0.2s; }
                .card-image { height: \(config.model.imageHeight)px; background: #2C2C2E; border-radius: 8px; }
                .card-title { color: #FFF; font-size: 18px; font-weight: 600; margin-top: 12px; }
                .card-subtitle { color: #8E8E93; font-size: 14px; margin-top: 4px; }
            </style>
        </head>
        <body>
            <div class="grid">
        """
        
        for card in config.cards {
            html += """
                <div class="card">
                    <div class="card-image"></div>
                    <div class="card-title">\(card.title)</div>
                    <div class="card-subtitle">\(card.subtitle ?? "")</div>
                </div>
            """
        }
        
        html += """
            </div>
        </body>
        </html>
        """
        
        return html
    }
}

// MARK: - Preview Utilities

extension CardPreview {
    
    /// All available previews
    static var allPreviews: [String: PreviewConfiguration] {
        [
            "Single Card": singleCard(),
            "Grid": grid(),
            "List": list(),
            "Horizontal Scroll": horizontalScroll(),
            "Large Cards": largeCards(),
            "Compact Cards": compactCards(),
            "Dark Theme": darkTheme(),
            "Light Theme": lightTheme(),
            "Colorful Theme": colorfulTheme(),
            "Hover State": hoverState(),
            "Selected State": selectedState(),
            "Favorite State": favoriteState(),
            "Archived State": archivedState(),
            "FlowKit Packages": flowKitPackages(),
            "Project Cards": projectCards()
        ]
    }
    
    /// Preview names
    static var previewNames: [String] {
        Array(allPreviews.keys).sorted()
    }
    
    /// Get preview by name
    static func preview(named name: String) -> PreviewConfiguration? {
        allPreviews[name]
    }
}
