# Layout Component System

## Overview

This is a property-based UI system that separates data from presentation, making it easy to develop with mock data and integrate with real data sources later.

## Architecture

```
/layout/components/
├── titlebar/
│   ├── properties/              ← File-based properties
│   ├── TitleBarModel.swift      ← Data model
│   └── TitleBarViewModel.swift  ← Business logic
├── navigation/
│   ├── properties/
│   ├── NavigationModel.swift
│   └── NavigationViewModel.swift
├── category/
│   ├── properties/
│   ├── CategoryModel.swift
│   └── CategoryViewModel.swift
├── panel/
│   ├── properties/
│   ├── PanelModel.swift
│   └── PanelViewModel.swift
├── content/
│   ├── properties/
│   ├── ContentModel.swift
│   └── ContentViewModel.swift
├── DataIntegration.swift        ← Property file loader
└── LayoutCoordinator.swift      ← Main orchestrator
```

## Component Hierarchy

```
┌─────────────────────────────────────────┐
│           TitleBar                      │ ← 52px height
├──────┬──────────────────────────────────┤
│ Nav  │ Category  │    Content           │
│ 72px │   200px   │                      │
│ Icon │ Toolbar   │   ┌──────────────┐   │
│ Only │ + Items   │   │   Inspector  │   │
│      │           │   │    280px     │   │
│ Exp  │           │   └──────────────┘   │
│ 220px│           │                      │
└──────┴───────────┴──────────────────────┘
        │
        └─── Floating Panels (up to 3)
             ├── Chat
             ├── Terminal
             ├── Console
             ├── Workflow
             ├── Agent
             ├── Documentation
             ├── History
             ├── Activity
             ├── Analytics
             ├── Notification
             ├── Settings
             └── Inspector
```

## Usage

### 1. Development Mode (Mock Data)

```swift
// Use mock data for UI development
let coordinator = LayoutCoordinator(useMockData: true)

// Or load from property files
let coordinator = LayoutCoordinator(useMockData: false)
```

### 2. Production Mode (Real Data)

```swift
// Create your data sources
class MyTitleBarDataSource: TitleBarDataSource {
    var titlePublisher: AnyPublisher<String, Never> {
        // Your real data publisher
    }
    var iconPublisher: AnyPublisher<String, Never> {
        // Your real data publisher
    }
}

// Connect to coordinator
coordinator.connectToRealData(
    titleBarDataSource: MyTitleBarDataSource(),
    navigationDataSource: MyNavigationDataSource(),
    categoryDataSource: MyCategoryDataSource(),
    panelDataSource: MyPanelDataSource(),
    contentDataSource: MyContentDataSource()
)
```

### 3. Property File System

All properties are stored as plain text files:

```
/titlebar/properties/TitleBarHeight → "52"
/titlebar/properties/TitleBarBackgroundColor → "#1C1C1E"
/navigation/properties/NavigationWidth → "72"
```

Load and save properties:

```swift
let loader = PropertyLoader.shared

// Load
let height = loader.loadInt(component: "titlebar", property: "TitleBarHeight")

// Save
try loader.saveProperty(component: "titlebar", property: "TitleBarHeight", value: "60")
```

## Components

### TitleBar
- Height, background color, alignment
- Icon and title display
- Control buttons (close, minimize, maximize, settings)
- Divider visibility

### Navigation Panel
- Icon-only mode (72px) / Expanded mode (220px)
- Expandable with animation
- Badge support
- Connects to titlebar

### Category Panel
- Width: 200px
- Toolbar at top (44px)
- Item list (32px per item)
- Connects to toolbar

### Panel System
- Floating panels (up to 3 simultaneously)
- 12 panel types: chat, notification, settings, terminal, console, workflow, agent, documentation, history, activity, analytics, inspector
- Draggable and resizable
- Minimize support
- Card-based UI with shadows

### Content View
- Main workspace area
- Optional inspector (280px, trailing/leading)
- Shows inspector when content selected
- Grid or list views

## Integration Steps

1. **Develop UI with mock data**
   ```swift
   let coordinator = LayoutCoordinator(useMockData: true)
   ```

2. **Test with property files**
   ```swift
   let coordinator = LayoutCoordinator(useMockData: false)
   ```

3. **Implement real data sources**
   ```swift
   class RealDataSource: TitleBarDataSource {
       // Implement protocol methods
   }
   ```

4. **Connect real data**
   ```swift
   coordinator.connectToRealData(...)
   ```

## Benefits

✅ **Separation of Concerns** - UI, data, and business logic are independent
✅ **Easy Testing** - Use mock data during development
✅ **File-Based Properties** - Edit via Terminal, Chat, Code, or UI
✅ **Gradual Integration** - Connect real data when ready
✅ **Type-Safe** - Swift models with full type checking
✅ **Observable** - Combine publishers for reactive updates

## Next Steps

- Create SwiftUI Views for each component
- Implement real data sources from FlowKit
- Add animations and transitions
- Integrate with existing window property system
