# FlowKit Integration - Usage Guide

## 🚀 Quick Start

### 1. Update FlowKit Path
Edit `/workspaces/layout/widow/integration/FlowKitAdapter.swift` line 12:

```swift
let flowKitRoot = URL(fileURLWithPath: "/YOUR/ACTUAL/PATH/TO/FlowKit")
```

Replace with your actual FlowKit project path from the terminal output you shared.

### 2. Run the Application

The app now opens with **FlowKit Integration** as the default view, showing:
- All 37 Kits organized by type
- Services from your project
- Views catalog
- HIG components

## 📋 Features Available

### Terminal Interface
```bash
# List all your kits
list-kits

# Show kits by type
list-kits  # Groups by Intelligence, Interaction, Infrastructure, etc.

# Import a kit as a package
import-kit AIKit

# Create project from kit
create-from-kit ChatKit MyChatApp

# Show kit details
kit-info WorkflowKit

# List your services
list-services

# FlowKit status
flowkit-status
```

### Chat Interface
```
"show me all kits"
"list AI kits"
"import AgentKit"
"create a project called MyApp using ChatKit"
"show me workflow services"
"what is HIG?"
```

### Visual Dashboard
- **Kits Tab**: Browse all 37 kits grouped by type
- **Services Tab**: Explore 70+ services by category
- **Views Tab**: Navigate 50+ views
- **HIG Tab**: Access design system components

## 🎯 Integration Points

### Your Architecture → Our System

| Your Component | Maps To | Actions Available |
|---|---|---|
| `package/AIKit/` | Package template | Import, create projects |
| `Services/` | Service registry | List, execute |
| `Views/` | View catalog | Browse, integrate |
| `HIG/` | Design system | Components, themes |
| `Package.swift` | Kit manifest | Parse dependencies |

### Available CRUD Operations

**Kits:**
- ✅ List all kits (grouped by type)
- ✅ Import kit as package
- ✅ Create project from kit
- ✅ View kit manifest

**Services:**
- ✅ List services (categorized)
- ✅ Execute service with parameters
- ✅ Browse by category (AI, Workflow, Storage, etc.)

**Views:**
- ✅ List all views
- ✅ Browse by category
- ✅ Search views

**Projects:**
- ✅ Create from kit template
- ✅ Manage properties
- ✅ Live editing

## 🔧 Customization

### Add Custom Kit Types
Edit `FlowKitAdapter.swift` `determineKitType()`:

```swift
case "MyCustomKit": return .custom
```

### Add Service Categories
Edit `FlowKitAdapter.swift` `categorizeService()`:

```swift
if name.contains("mypattern") { return .myCategory }
```

### Map Additional Components
Extend `KitPackageMapper.swift` `extractKitProperties()`:

```swift
properties["CustomField"] = extractCustomData()
```

## 📦 Package Generation

When you import a kit, it automatically:
1. Parses `Package.swift`
2. Extracts dependencies
3. Scans for Models/Views/Services
4. Generates `.pkg` file in `/Packages/`
5. Creates window properties for visualization

## 🎨 Design Integration

Your HIG components are mapped to our design system:
- `HIGButtons` → Button components
- `HIGTextfields` → Input components
- `HIGLists` → List components
- Design tokens automatically extracted

## 🔄 Live Sync

Changes in your FlowKit project can be synced:
- File system monitoring on your package directory
- Real-time kit detection
- Service discovery
- View catalog updates

## 💡 Example Workflows

### Workflow 1: Create Chat App from ChatKit
```bash
# Terminal
import-kit ChatKit
create-from-kit ChatKit SuperChat

# Or Chat
"import ChatKit"
"create a project called SuperChat using ChatKit"
```

### Workflow 2: Explore AI Services
```bash
# Terminal
list-services

# Or Chat
"show me AI services"
```

### Workflow 3: Browse Design Components
```bash
# Terminal
list-hig

# Or Visual Dashboard
Click "HIG" tab → Browse components
```

## 🎪 Next Steps

1. **Update the path** to your actual FlowKit location
2. **Run the app** and see your 37 kits
3. **Import a kit** you want to work with
4. **Create a project** from that kit
5. **Use Terminal/Chat** for rapid operations

Your entire FlowKit ecosystem is now integrated with live editing, Terminal commands, Chat interface, and visual management! 🚀
