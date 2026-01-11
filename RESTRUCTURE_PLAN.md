# 🏗️ Restructured Component System

## 📋 Component Hierarchy

### Top-Level Components
```
layout/
├── components/
│   ├── bars/          (TitleBar, StatusBar, PathBar, Toolbar, Breadcrumbs)
│   ├── panels/        (SidePanel, FloatingPanel, PreviewPanel)
│   ├── tabs/          (Tabs, VerticalTabs)
│   ├── navigation/    (Navigation, Menus)
│   ├── cards/         (Card variations)
│   ├── controls/      (Buttons, Chips, Accordion, Segmented, Steppers)
│   ├── displays/      (Badges, Charts, Feeds, Widgets)
│   └── menus/         (Context, Dropdown, Bento, Hamburger)
│
├── models/
│   ├── BarModels/
│   │   ├── TitleBarModel/
│   │   │   ├── properties/
│   │   │   ├── attributes/
│   │   │   ├── operations/
│   │   │   ├── types/
│   │   │   ├── strings/
│   │   │   └── collections/
│   │   ├── StatusBarModel/
│   │   ├── PathBarModel/
│   │   ├── ToolbarModel/
│   │   └── BreadcrumbsModel/
│   │
│   ├── PanelModels/
│   │   ├── SidePanelModel/
│   │   ├── FloatingPanelModel/
│   │   └── PreviewPanelModel/
│   │
│   ├── TabModels/
│   │   ├── TabsModel/
│   │   └── VerticalTabsModel/
│   │
│   ├── NavigationModels/
│   ├── CardModels/
│   ├── ControlModels/
│   ├── DisplayModels/
│   └── MenuModels/
│
└── platform/
    ├── iOS/
    ├── tvOS/
    ├── macOS/
    ├── visionOS/
    └── watchOS/
```

## 🎯 New Structure Principles

### 1. Component-Model Matching
- Each component has exactly one matching model
- Models organized by category (Bars, Panels, Tabs, etc.)

### 2. File Granularity
- Each property → own file
- Each attribute → own file
- Each operation → own file
- Each type definition → own file
- Each string constant → own file
- Each collection type → own file

### 3. Platform Support
- iOS (UIKit)
- tvOS (UIKit for TV)
- macOS (AppKit)
- visionOS (SwiftUI for Vision)
- watchOS (SwiftUI for Watch)

### 4. Hierarchical Organization
```
Component
  └── Model
      ├── Properties (files)
      ├── Attributes (files)
      ├── Operations (files)
      ├── Types (files)
      ├── Strings (files)
      └── Collections (files)
```

---

## 📊 Component Breakdown

### Bars Category
- **TitleBar** - Window title with icon, controls
- **StatusBar** - Bottom status information
- **PathBar** - Breadcrumb navigation path
- **Toolbar** - Top toolbar with actions
- **Breadcrumbs** - Navigation breadcrumbs

### Panels Category
- **SidePanel** - Collapsible side panel
- **FloatingPanel** - Floating overlay panel
- **PreviewPanel** - Content preview panel

### Tabs Category
- **Tabs** - Horizontal tabs
- **VerticalTabs** - Vertical tab layout

### Controls Category
- **Buttons** - Action buttons
- **Chips** - Selection chips
- **Accordion** - Expandable sections
- **Segmented** - Segmented control
- **Steppers** - Numeric steppers

### Displays Category
- **Badges** - Notification badges
- **Charts** - Data visualization
- **Feeds** - Content feeds
- **Widgets** - Dashboard widgets

### Menus Category
- **Context** - Right-click context menu
- **Dropdown** - Dropdown menu
- **Bento** - Grid menu layout
- **Hamburger** - Mobile menu

---

This restructuring will create a more maintainable, scalable system. Should I proceed with implementing this new structure?
