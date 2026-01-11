# UI Blueprint - Complete Component Breakdown

## 📐 Layout Structure

```
┌──────────────────────────────────────────────────────────┐
│  TitleBar (52px) - #1C1C1E                              │
│  [Icon] Project Name         [Close][Min][Max][Settings]│
├─────┬────────────┬────────────────────────────────────────┤
│ Nav │  Category  │           Content Area                 │
│ 72px│   200px    │                                        │
│     │            │  ┌────────────────────────────────┐    │
│ ☰   │ Toolbar    │  │                                │    │
│ 📁  │ ─────────  │  │                                │    │
│ 📦  │ All (12)   │  │      Main Content              │    │
│ 💬  │ Recent (5) │  │                                │    │
│ ⚙️  │ Favs (3)   │  │                                │    │
│ 📚  │ Archive    │  │                                │    │
│     │            │  └────────────────────────────────┘    │
│ Exp │            │              ┌──────────────────┐      │
│ 220 │            │              │   Inspector      │      │
│     │            │              │   280px          │      │
└─────┴────────────┴──────────────┴──────────────────┴──────┘

Floating Panels (3 max):
┌──────────────────────┐  ┌──────────────────────┐
│ 💬 Chat Panel        │  │ 🖥️ Terminal Panel    │
│ ─────────────────── │  │ ─────────────────── │
│                      │  │                      │
│  [Panel content]     │  │  [Panel content]     │
│                      │  │                      │
│                      │  │                      │
│  [320px min width]   │  │  [320px min width]   │
│  [240px min height]  │  │  [240px min height]  │
└──────────────────────┘  └──────────────────────┘
```

## 🎨 Component Properties Breakdown

### 1️⃣ TitleBar Component
**Location:** `/layout/components/titlebar/`

**Properties (9 files):**
- `TitleBarHeight` → 52
- `TitleBarBackgroundColor` → #1C1C1E
- `TitleBarAlignment` → leading
- `TitleBarShowsTitle` → true
- `TitleBarShowsIcon` → true
- `TitleBarIconSize` → 24
- `TitleBarButtons` → close,minimize,maximize,settings
- `TitleBarButtonsPosition` → trailing
- `TitleBarDividerVisible` → true

**Model:** `TitleBarModel.swift`
- Enums: Alignment, TitleBarButton
- Factory: `.mock()` for development
- Loader: `.fromProperties()` for production

**ViewModel:** `TitleBarViewModel.swift`
- Actions: `handleButtonTap(_:)`
- Integration: `connectToRealData(_:)` protocol
- Observable properties for reactive UI

---

### 2️⃣ Navigation Panel Component
**Location:** `/layout/components/navigation/`

**Properties (8 files):**
- `NavigationWidth` → 72
- `NavigationExpandedWidth` → 220
- `NavigationIsExpanded` → false
- `NavigationBackgroundColor` → #2C2C2E
- `NavigationIconSize` → 28
- `NavigationItemSpacing` → 12
- `NavigationShowLabels` → false
- `NavigationItems` → projects,packages,chat,terminal,settings,help
- `NavigationConnectsToTitleBar` → true

**Model:** `NavigationModel.swift`
- Struct: `NavigationItem` (id, name, icon, badge)
- Mock items: 6 navigation items with badges

**ViewModel:** `NavigationViewModel.swift`
- Actions: `toggleExpansion()`, `select(_:)`, `setHoveredItem(_:)`
- State: selectedItem, hoveredItem
- Badge management: `clearBadge(for:)`

---

### 3️⃣ Category Panel Component
**Location:** `/layout/components/category/`

**Properties (6 files):**
- `CategoryWidth` → 200
- `CategoryBackgroundColor` → #2C2C2E
- `CategoryShowsToolbar` → true
- `CategoryToolbarHeight` → 44
- `CategoryItemHeight` → 32
- `CategoryConnectsToToolbar` → true

**Model:** `CategoryModel.swift`
- Struct: `Category` (id, name, icon, count, color)
- Mock categories: All Projects, Recent, Favorites, Templates, Archived

**ViewModel:** `CategoryViewModel.swift`
- Actions: `select(_:)`, `addCategory(name:icon:)`
- Search: `filterCategories()` with searchText
- State: selectedCategory, filteredCategories

---

### 4️⃣ Panel System Component
**Location:** `/layout/components/panel/`

**Properties (8 files):**
- `PanelMaxCount` → 3
- `PanelFloats` → true
- `PanelMinWidth` → 320
- `PanelMinHeight` → 240
- `PanelTypes` → chat,notification,settings,terminal,console,workflow,agent,documentation,history,activity,analytics,inspector
- `PanelCardCornerRadius` → 12
- `PanelCardShadow` → true
- `PanelCardBackgroundColor` → #1C1C1E

**Model:** `PanelModel.swift`
- Enum: `PanelType` (12 types with icons)
- Struct: `ActivePanel` (id, type, position, size, isMinimized)

**ViewModel:** `PanelViewModel.swift`
- Actions: `openPanel(type:)`, `closePanel(_:)`, `toggleMinimize(_:)`
- Drag/Drop: `updatePanelPosition(_:to:)`
- Resize: `updatePanelSize(_:to:)`
- Z-order: `bringToFront(_:)`
- Constraints: Enforces min size, max count

**Panel Types:**
1. chat → bubble.left.and.bubble.right
2. notification → bell.fill
3. settings → gearshape
4. terminal → terminal
5. console → list.bullet.rectangle
6. workflow → arrow.triangle.branch
7. agent → person.crop.circle.badge.checkmark
8. documentation → doc.text
9. history → clock.arrow.circlepath
10. activity → chart.line.uptrend.xyaxis
11. analytics → chart.bar.fill
12. inspector → info.circle

---

### 5️⃣ Content View Component
**Location:** `/layout/components/content/`

**Properties (4 files):**
- `ContentBackgroundColor` → #000000
- `ContentShowsInspector` → false
- `InspectorWidth` → 280
- `InspectorPosition` → trailing

**Model:** `ContentModel.swift`
- Enum: `Position`, `ItemType`
- Struct: `ContentItem` (id, title, subtitle, icon, type, metadata)
- Mock items: 3 sample projects/packages

**ViewModel:** `ContentViewModel.swift`
- Actions: `select(_:)`, `deselectItem()`, `toggleInspector()`
- CRUD: `createItem(title:type:)`, `deleteItem(_:)`
- Search: `filterItems()` with searchText
- Auto-show inspector when item selected

---

## 🔌 Integration System

### PropertyLoader (`DataIntegration.swift`)
**Purpose:** Bridge between property files and models

**Methods:**
- `loadString()` - Load text property
- `loadInt()` - Load numeric property
- `loadDouble()` - Load decimal property
- `loadBool()` - Load boolean (true/false/yes/no/1/0)
- `loadArray()` - Load comma-separated lists
- `saveProperty()` - Write property back to file

**Model Loaders:**
- `loadTitleBarModel()` → Reads all titlebar properties
- `loadNavigationModel()` → Reads all navigation properties
- `loadCategoryModel()` → Reads all category properties
- `loadPanelModel()` → Reads all panel properties
- `loadContentModel()` → Reads all content properties

### LayoutCoordinator
**Purpose:** Central orchestrator for all components

**Usage:**
```swift
// Development mode (mock data)
let coordinator = LayoutCoordinator(useMockData: true)

// Production mode (from property files)
let coordinator = LayoutCoordinator(useMockData: false)

// Integration with real data
coordinator.connectToRealData(
    titleBarDataSource: realTitleBarSource,
    navigationDataSource: realNavSource,
    categoryDataSource: realCategorySource,
    panelDataSource: realPanelSource,
    contentDataSource: realContentSource
)
```

**Features:**
- Auto-binding between components
- Navigation → Content synchronization
- Category → Content filtering
- Content selection → Inspector visibility
- Theme management

---

## 📦 Data Flow

```
┌─────────────────────────────────────────────┐
│          Property Files (Plain Text)        │
│  /titlebar/properties/TitleBarHeight        │
└──────────────────┬──────────────────────────┘
                   ↓
┌─────────────────────────────────────────────┐
│          PropertyLoader                      │
│  - loadInt(), loadString(), loadBool()      │
└──────────────────┬──────────────────────────┘
                   ↓
┌─────────────────────────────────────────────┐
│          DataIntegration                     │
│  - loadTitleBarModel()                      │
│  - loadNavigationModel()                    │
└──────────────────┬──────────────────────────┘
                   ↓
┌─────────────────────────────────────────────┐
│          Models (Structs)                    │
│  TitleBarModel, NavigationModel, etc.       │
└──────────────────┬──────────────────────────┘
                   ↓
┌─────────────────────────────────────────────┐
│          ViewModels (@Published)             │
│  TitleBarViewModel, NavigationViewModel     │
└──────────────────┬──────────────────────────┘
                   ↓
┌─────────────────────────────────────────────┐
│          LayoutCoordinator                   │
│  Orchestrates all components                │
└──────────────────┬──────────────────────────┘
                   ↓
┌─────────────────────────────────────────────┐
│          SwiftUI Views                       │
│  (To be created)                            │
└─────────────────────────────────────────────┘
```

---

## 🚀 Usage Examples

### Example 1: Basic Setup
```swift
import SwiftUI

struct MyApp: App {
    @StateObject var coordinator = LayoutCoordinator(useMockData: true)
    
    var body: some Scene {
        WindowGroup {
            MainLayoutView()
                .environmentObject(coordinator)
        }
    }
}
```

### Example 2: Navigation Interaction
```swift
// In NavigationView
Button(action: {
    coordinator.navigation.select(item)
    coordinator.navigation.toggleExpansion()
}) {
    HStack {
        Image(systemName: item.icon)
            .font(.system(size: coordinator.navigation.model.iconSize))
        
        if coordinator.navigation.model.showLabels {
            Text(item.name)
        }
    }
}
```

### Example 3: Panel Management
```swift
// Open a panel
coordinator.panel.openPanel(type: .terminal)

// Drag panel
coordinator.panel.updatePanelPosition(panel, to: newPosition)

// Resize panel
coordinator.panel.updatePanelSize(panel, to: newSize)

// Close panel
coordinator.panel.closePanel(panel)
```

### Example 4: Property Updates
```swift
// Update property file
try PropertyLoader.shared.saveProperty(
    component: "titlebar",
    property: "TitleBarHeight",
    value: "60"
)

// Reload model
coordinator.titleBar.model = DataIntegration.loadTitleBarModel()
```

---

## ✨ Key Features

1. **File-Based Properties** - Edit via Terminal, Chat, Code, or UI
2. **Mock Data Support** - Develop UI without backend
3. **Type-Safe Models** - Full Swift type checking
4. **Observable ViewModels** - Reactive updates with Combine
5. **Easy Integration** - Protocol-based data source connection
6. **Modular Components** - Independent, reusable pieces
7. **Coordinated State** - Central orchestration
8. **Property Validation** - Min/max constraints enforced

---

## 📝 Next Steps

1. ✅ Property files created (36 files)
2. ✅ Models created (5 models)
3. ✅ ViewModels created (5 view models)
4. ✅ Integration bridge created
5. ✅ Coordinator created
6. ⏳ Create SwiftUI Views
7. ⏳ Implement real data sources
8. ⏳ Add animations
9. ⏳ Connect to FlowKit

**Total Files Created:** 52 files
- 36 property files
- 5 models
- 5 view models
- 2 integration files
- 1 coordinator
- 1 README
- 1 blueprint (this file)
