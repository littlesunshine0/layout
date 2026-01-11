# 🎯 Quick Integration Guide

## ✅ What's Complete

**Total: 53 Files Created**

### Property Files (36)
- ✅ TitleBar: 9 properties
- ✅ Navigation: 9 properties  
- ✅ Category: 6 properties
- ✅ Panel: 8 properties
- ✅ Content: 4 properties

### Models (5)
- ✅ TitleBarModel.swift
- ✅ NavigationModel.swift
- ✅ CategoryModel.swift
- ✅ PanelModel.swift
- ✅ ContentModel.swift

### ViewModels (5)
- ✅ TitleBarViewModel.swift
- ✅ NavigationViewModel.swift
- ✅ CategoryViewModel.swift
- ✅ PanelViewModel.swift
- ✅ ContentViewModel.swift

### Integration (3)
- ✅ DataIntegration.swift (Property loader)
- ✅ LayoutCoordinator.swift (Main orchestrator)
- ✅ Examples.swift (Usage examples)

### Documentation (4)
- ✅ README.md (Full documentation)
- ✅ BLUEPRINT.md (Visual structure)
- ✅ INTEGRATION.md (This file)

---

## 🚀 How to Use

### Step 1: Import in Your Project

```swift
import Foundation

// Create coordinator
let coordinator = LayoutCoordinator(useMockData: true)

// Access components
coordinator.titleBar
coordinator.navigation
coordinator.category
coordinator.panel
coordinator.content
```

### Step 2: Connect to SwiftUI

```swift
import SwiftUI

struct MainLayoutView: View {
    @EnvironmentObject var coordinator: LayoutCoordinator
    
    var body: some View {
        VStack(spacing: 0) {
            // TitleBar
            TitleBarView()
            
            HStack(spacing: 0) {
                // Navigation
                NavigationView()
                
                // Category
                CategoryView()
                
                // Content
                ContentView()
            }
        }
        .overlay(
            // Floating Panels
            PanelsOverlay()
        )
    }
}

@main
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

### Step 3: Create SwiftUI Views

Each component needs a SwiftUI view. Here's a template:

```swift
// TitleBarView.swift
import SwiftUI

struct TitleBarView: View {
    @EnvironmentObject var coordinator: LayoutCoordinator
    
    var body: some View {
        HStack {
            // Left side: Icon + Title
            if coordinator.titleBar.model.showsIcon {
                Image(systemName: coordinator.titleBar.projectIcon)
                    .resizable()
                    .frame(width: coordinator.titleBar.model.iconSize,
                           height: coordinator.titleBar.model.iconSize)
            }
            
            if coordinator.titleBar.model.showsTitle {
                Text(coordinator.titleBar.projectTitle)
                    .font(.headline)
            }
            
            Spacer()
            
            // Right side: Buttons
            HStack(spacing: 8) {
                ForEach(coordinator.titleBar.model.buttons, id: \.self) { button in
                    Button(action: {
                        coordinator.titleBar.handleButtonTap(button)
                    }) {
                        Image(systemName: button.icon)
                    }
                }
            }
        }
        .padding()
        .frame(height: coordinator.titleBar.model.height)
        .background(Color(hex: coordinator.titleBar.model.backgroundColor))
    }
}
```

---

## 🔌 Integration with FlowKit

### Option 1: Use FlowKit as Data Source

```swift
// Create FlowKit data sources
class FlowKitNavigationSource: NavigationDataSource {
    var itemsPublisher: AnyPublisher<[NavigationModel.NavigationItem], Never> {
        // Pull from FlowKit's package list
        FlowKitAdapter.shared.$availableKits
            .map { kits in
                kits.map { kit in
                    NavigationModel.NavigationItem(
                        name: kit.name,
                        icon: kit.icon,
                        badge: kit.unreadCount
                    )
                }
            }
            .eraseToAnyPublisher()
    }
    
    func updateBadge(for item: String, count: Int) {
        // Update FlowKit
    }
}

// Connect
coordinator.connectToRealData(
    titleBarDataSource: FlowKitTitleBarSource(),
    navigationDataSource: FlowKitNavigationSource(),
    categoryDataSource: FlowKitCategorySource(),
    panelDataSource: FlowKitPanelSource(),
    contentDataSource: FlowKitContentSource()
)
```

### Option 2: Hybrid Approach

```swift
// Use properties for UI configuration
let coordinator = LayoutCoordinator(useMockData: false) // Load from files

// Connect FlowKit data for content
coordinator.content.connectToRealData(FlowKitContentSource())
```

---

## 📝 Property File Editing

### Via Terminal
```bash
# Update titlebar height
echo "60" > /workspaces/layout/layout/components/titlebar/properties/TitleBarHeight

# Change navigation width
echo "80" > /workspaces/layout/layout/components/navigation/properties/NavigationWidth

# Add panel type
echo "chat,terminal,inspector,custom" > /workspaces/layout/layout/components/panel/properties/PanelTypes
```

### Via Chat
```
User: "make the titlebar taller"
Agent: Updates TitleBarHeight to 60

User: "expand navigation by default"
Agent: Sets NavigationIsExpanded to true
```

### Via Code
```swift
try PropertyLoader.shared.saveProperty(
    component: "titlebar",
    property: "TitleBarHeight",
    value: "60"
)
```

---

## 🎨 Styling

All colors are hex strings in property files:

```
TitleBarBackgroundColor → #1C1C1E
NavigationBackgroundColor → #2C2C2E
CategoryBackgroundColor → #2C2C2E
PanelCardBackgroundColor → #1C1C1E
ContentBackgroundColor → #000000
```

Update via SwiftUI:

```swift
.background(Color(hex: model.backgroundColor))
```

Add Color extension:

```swift
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        r = (int >> 16) & 0xFF
        g = (int >> 8) & 0xFF
        b = int & 0xFF
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: 1
        )
    }
}
```

---

## 🔄 Data Flow Summary

```
Property Files (.txt)
        ↓
PropertyLoader (reads/writes)
        ↓
DataIntegration (transforms)
        ↓
Models (TitleBarModel, etc.)
        ↓
ViewModels (@Published)
        ↓
LayoutCoordinator (orchestrates)
        ↓
SwiftUI Views
        ↓
User Interface
```

---

## ✨ Key Benefits

1. **Separation of Concerns**
   - UI properties in files
   - Business logic in ViewModels
   - Data in Models
   - Coordination in LayoutCoordinator

2. **Easy Development**
   - Use mock data first
   - Test without backend
   - Gradual integration

3. **Multi-Interface Editing**
   - Terminal commands
   - Chat AI
   - Code editor
   - UI controls
   All modify same property files

4. **Type Safety**
   - Swift models
   - Enums for options
   - Validation in ViewModels

5. **Observable**
   - Combine publishers
   - Reactive updates
   - Auto-refresh UI

---

## 🛠️ Next Steps

### Phase 1: SwiftUI Views
```
[ ] Create TitleBarView.swift
[ ] Create NavigationView.swift
[ ] Create CategoryView.swift
[ ] Create PanelView.swift
[ ] Create ContentView.swift
[ ] Create MainLayoutView.swift
```

### Phase 2: Animations
```
[ ] Navigation expand/collapse
[ ] Panel drag/drop
[ ] Panel resize
[ ] Panel minimize
[ ] Content selection
```

### Phase 3: FlowKit Integration
```
[ ] Create FlowKit data sources
[ ] Map FlowKit kits to navigation
[ ] Map FlowKit projects to content
[ ] Connect panel types to FlowKit tools
```

### Phase 4: Advanced Features
```
[ ] Save/restore panel layouts
[ ] Keyboard shortcuts
[ ] Theme system
[ ] Accessibility
```

---

## 📚 Related Files

- Window properties: `/workspaces/layout/widow/properties/`
- FlowKit adapter: `/workspaces/layout/widow/integration/FlowKitAdapter.swift`
- Package manager: `/workspaces/layout/widow/packages/PackageManager.swift`

---

**Ready to build the UI! All foundation is in place. 🎉**
