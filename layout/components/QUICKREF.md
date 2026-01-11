# 🎯 Quick Reference Guide

## Component Cheat Sheet

### Card Component
```swift
// Create
viewModel.createCard(title: "Project", subtitle: "Swift", tags: ["ios"])

// Read
let card = viewModel.getCard(byId: "123")
let filtered = viewModel.filteredCards()

// Update
viewModel.updateCardTitle("123", title: "New Title")
viewModel.toggleFavorite("123")

// Delete
viewModel.deleteCard("123")
```

### PreviewPanel Component
```swift
// Load preview
viewModel.loadPreview("image.png", type: .image)

// Zoom
viewModel.zoomIn()
viewModel.zoomOut()
viewModel.resetZoom()

// Edit
viewModel.enableEditing()
viewModel.saveChanges()
```

### Tabs Component
```swift
// Add tab
viewModel.addTab(title: "File.swift", icon: "doc.text")

// Select
viewModel.selectTab("tab-id")

// Reorder
viewModel.reorderTabs(from: 0, to: 2)

// Pin
viewModel.pinTab("tab-id")
```

### StatusBar Component
```swift
// Add status item
viewModel.addItem(.leading, icon: "clock", text: "10:30 AM")
viewModel.addItem(.center, icon: "network", text: "Connected")
viewModel.addItem(.trailing, icon: "battery.100", text: "100%")

// Update
viewModel.updateItem("item-id", text: "New Status")
```

### PathBar Component
```swift
// Set path
viewModel.setPath("/Users/name/Projects/MyApp")

// Navigate
viewModel.navigateToSegment(2) // Jump to segment

// Parse
let segments = viewModel.segments // Get all segments
```

---

## Generator Quick Reference

### Card Generator
```swift
// From template
let card = CardGenerator.generateCard(from: .project, customData: ["title": "MyApp"])

// Batch
let cards = CardGenerator.generateCards(count: 10, from: .package)

// From CSV
let csv = "title,subtitle\nProject1,Swift\nProject2,Python"
let cards = CardGenerator.generateCards(from: csv)

// To JSON
let data = CardGenerator.exportToJSON(cards)
```

### PreviewPanel Generator
```swift
// Generate preview
let preview = PreviewPanelGenerator.generatePreview(
    filename: "image.png",
    type: .image,
    metadata: ["size": "1920x1080"]
)
```

### Tabs Generator
```swift
// From files
let files = ["main.swift", "app.swift", "view.swift"]
let tabs = TabsGenerator.generateTabs(from: files)
```

---

## Editor Quick Reference

### Card Editor
```swift
// Edit
var card = viewModel.getCard(byId: "123")!
CardEditor.edit(&card, changes: [
    .title: "New Title",
    .subtitle: "New Subtitle"
])

// Validate
let result = CardEditor.validate(card)
if result.isValid {
    viewModel.updateCard(card)
}

// Transform
CardEditor.transform(&card, transformation: .uppercase)

// Merge
let merged = CardEditor.merge(card1, with: card2, strategy: .combine)
```

---

## Icons Quick Reference

### Card Icons
```swift
// Get icon for type
let icon = CardIcons.icon(for: "project") // "folder"

// Get icon for file
let icon = CardIcons.icon(forExtension: "swift") // "swift"

// Get FlowKit icon
let icon = CardIcons.icon(forFlowKitPackage: "IdeaKit") // "lightbulb"

// Search
let icons = CardIcons.search("folder")
```

### Icon Colors
```swift
let color = CardIconColors.color(for: "success") // "#34C759"
```

---

## Preview Quick Reference

### Card Previews
```swift
// Get preview
let config = CardPreview.grid()
let config = CardPreview.darkTheme()
let config = CardPreview.flowKitPackages()

// Generate HTML
let html = CardPreview.generateHTML(config)

// All previews
let all = CardPreview.allPreviews
let names = CardPreview.previewNames
```

---

## Platform Mapping Reference

### Get Component Name
```swift
let name = PlatformComponentMapper.componentName(
    for: .card,
    platform: .swiftUI
) // "VStack / HStack (Custom)"
```

### Generate Code
```swift
let code = PlatformComponentMapper.generateCode(
    for: .card,
    platform: .swiftUI,
    properties: ["width": 280, "height": 320]
)
```

### Migration Guide
```swift
let guide = PlatformComponentMapper.migrationGuide(
    from: .uiKit,
    to: .swiftUI,
    component: .card
)
```

---

## Property File Reference

### Load Property
```swift
let width = PropertyLoader.shared.loadDouble(
    component: "card",
    property: "CardWidth",
    defaultValue: 280
)
```

### Save Property
```swift
try PropertyLoader.shared.saveProperty(
    component: "card",
    property: "CardWidth",
    value: "300"
)
```

---

## Model Reference

### Load from Properties
```swift
let model = CardModel.fromProperties()
```

### Mock Data
```swift
let model = CardModel.mock()
let cards = CardModel.mockCards()
```

---

## ViewModel Reference

### Initialization
```swift
// With mock data
let viewModel = CardViewModel()

// With custom data
let viewModel = CardViewModel(
    model: CardModel.fromProperties(),
    cards: myCards
)
```

### Connect to Real Data
```swift
class MyDataSource: CardDataSource {
    var cardsPublisher: AnyPublisher<[CardModel.Card], Never> {
        // Your implementation
    }
    
    func createCard(_ card: CardModel.Card) { }
    func updateCard(_ card: CardModel.Card) { }
    func deleteCard(_ cardId: String) { }
}

let dataSource = MyDataSource()
viewModel.connectToRealData(dataSource)
```

---

## Complete Example

```swift
import SwiftUI

// 1. Create ViewModel
@StateObject var cardViewModel = CardViewModel()

// 2. Generate Cards
let packages = ["IdeaKit", "IconKit", "ChatKit"]
let cards = CardGenerator.generateFlowKitCards(packages: packages)

// 3. Add to ViewModel
cards.forEach { card in
    cardViewModel.createCard(
        title: card.title,
        subtitle: card.subtitle,
        imageName: card.imageName,
        tags: card.tags
    )
}

// 4. Display in SwiftUI
var body: some View {
    ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 280))], spacing: 16) {
            ForEach(cardViewModel.filteredCards()) { card in
                CardView(card: card)
                    .onTapGesture {
                        cardViewModel.selectCard(card.id)
                    }
            }
        }
        .padding()
    }
    .searchable(text: $cardViewModel.searchQuery)
}
```

---

## Property File Examples

### Card Properties
```bash
# Layout
echo "280" > CardWidth
echo "320" > CardHeight
echo "16" > CardPadding

# Visual
echo "#1C1C1E" > CardBackgroundColor
echo "12" > CardCornerRadius

# Shadow
echo "true" > CardShadowEnabled
echo "8" > CardShadowRadius
```

### Tabs Properties
```bash
echo "44" > TabsHeight
echo "#007AFF" > TabsActiveColor
echo "#8E8E93" > TabsInactiveColor
echo "true" > TabsShowsCloseButton
```

---

## CLI Commands (Future)

```bash
# Create card
layout card create --title "MyApp" --subtitle "Swift" --tags "ios,swift"

# List cards
layout card list --filter "favorite"

# Export cards
layout card export --format json --output cards.json

# Generate from template
layout card generate --template project --count 10

# Update property
layout property set card CardWidth 300
```

---

## Integration Patterns

### Pattern 1: Property → Model → ViewModel → View
```swift
// 1. Property files define configuration
CardWidth = 280
CardHeight = 320

// 2. Model loads from properties
let model = CardModel.fromProperties()

// 3. ViewModel manages state
let viewModel = CardViewModel(model: model)

// 4. View observes ViewModel
@ObservedObject var viewModel: CardViewModel
```

### Pattern 2: Mock → Develop → Connect Real Data
```swift
// 1. Start with mock data
let viewModel = CardViewModel() // Uses mock

// 2. Develop UI
CardView(card: viewModel.cards[0])

// 3. Connect real data when ready
viewModel.connectToRealData(FlowKitDataSource())
```

### Pattern 3: Generate → Edit → Validate → Save
```swift
// 1. Generate
var card = CardGenerator.generateCard(from: .project)

// 2. Edit
CardEditor.edit(&card, changes: [.title: "MyApp"])

// 3. Validate
let result = CardEditor.validate(card)

// 4. Save
if result.isValid {
    viewModel.createCard(...)
}
```

---

## Keyboard Shortcuts (Future)

```
⌘N - New card
⌘E - Edit card
⌘D - Duplicate card
⌘⌫ - Delete card
⌘F - Search
⌘T - New tab
⌘W - Close tab
⌘1-9 - Switch tabs
⌘⇧T - Reopen closed tab
```

---

## Best Practices

### ✅ Do
- Use property files for configuration
- Start with mock data
- Validate before saving
- Use generators for batch operations
- Implement DataSource protocol for real data
- Use ViewModels as single source of truth
- Follow CRUD patterns consistently

### ❌ Don't
- Hardcode values in views
- Mutate models directly (use ViewModels)
- Skip validation
- Mix mock and real data
- Bypass CRUD operations
- Access properties directly from views

---

## Common Recipes

### Recipe 1: Create Project Card System
```swift
// 1. Load model from properties
let model = CardModel.fromProperties()

// 2. Create ViewModel
let viewModel = CardViewModel(model: model)

// 3. Generate cards from FlowKit
let kits = FlowKitAdapter.shared.availableKits
kits.forEach { kit in
    viewModel.createCard(
        title: kit.name,
        subtitle: "FlowKit Package",
        imageName: CardIcons.icon(forFlowKitPackage: kit.name),
        tags: ["flowkit", "package"]
    )
}

// 4. Display in grid
CardGridView(cards: viewModel.filteredCards(), columns: 3)
```

### Recipe 2: Add Search and Filter
```swift
// Add search
TextField("Search", text: $viewModel.searchQuery)

// Add tag filter
ForEach(viewModel.allTags, id: \.self) { tag in
    Toggle(tag, isOn: Binding(
        get: { viewModel.filterTags.contains(tag) },
        set: { isOn in
            if isOn {
                viewModel.filterTags.insert(tag)
            } else {
                viewModel.filterTags.remove(tag)
            }
        }
    ))
}
```

### Recipe 3: Export and Import
```swift
// Export
if let data = viewModel.exportCards() {
    try data.write(to: url)
}

// Import
if let data = try? Data(contentsOf: url) {
    viewModel.importCards(from: data)
}
```

---

**Quick Tip:** All components follow the same patterns! Learn one, know them all! 🎓
