# Layout Models Pattern Definition (Dual Structure)

## 1. Unified Models (Canonical)
- BarModel/
- PanelModel/
- CardModel/
- TabModel/
- ControlModel/
- DisplayModel/
- MenuModel/

Follow the canonical structure:
- properties/{layout,style,content,behavior}/
- attributes/
- operations/
- types/
- strings/
- collections/

## 2. Legacy Sub-Model Collections (Plural)
- BarModels/
- PanelModels/
- TabModels/
- ControlModels/
- DisplayModels/
- MenuModels/

Contain specialized or legacy sub-models (e.g., TitleBarModel, FloatingPanelModel, etc.).

## 3. Integration Pattern
- Unified model’s type enum (e.g., BarType) should enumerate all sub-models found in the plural directory.
- Example: BarType.swift → enum BarType { case title, path, status, breadcrumbs, toolbar }
- Unified model can instantiate or reference sub-models from the plural directory for advanced/legacy use cases.

## 4. Usage Guidance
- Prefer unified models for new code and cross-cutting features.
- Use legacy sub-models for specialized, legacy, or highly granular needs.
- When adding new subtypes, update both the unified model’s type enum and the plural directory as needed.

## 5. Migration/Refactoring
- Over time, sub-models can be refactored into the unified model structure, or kept for backward compatibility.
- Both patterns are supported and documented.

## Directory Structure

All models follow this canonical structure:

```
ModelName/
├── properties/
│   ├── layout/       (plain text property files)
│   ├── style/        (plain text property files)
│   ├── content/      (plain text property files)
│   └── behavior/     (plain text property files)
├── attributes/       (4 Swift files)
├── operations/       (6 Swift files)
├── types/            (3-4 Swift files)
├── strings/          (3-4 plain text files)
└── collections/      (3 Swift files)
```

## Core Properties (ALL Models Must Have)

### properties/layout/
- `width` - default: "auto"
- `height` - default: "auto"
- `padding` - default: "8"
- `spacing` - default: "4"
- `position` - default: "relative"

### properties/style/
- `backgroundColor` - default: "#FFFFFF"
- `borderRadius` - default: "4"
- `borderWidth` - default: "1"
- `opacity` - default: "1.0"
- `shadowOffset` - default: "0,2"
- `shadowOpacity` - default: "0.1"

### properties/behavior/
- `isVisible` - default: "true"
- `isEnabled` - default: "true"
- `isInteractive` - default: "true"

## Standard Files (ALL Models Must Have)

### operations/ (6 files)
1. `Create.swift` - Factory methods
2. `Read.swift` - Query methods
3. `Update.swift` - Mutation methods
4. `Delete.swift` - Removal methods
5. `Toggle.swift` - State toggle methods
6. `Validate.swift` - Validation logic

### types/ (minimum 3 files)
1. `{Model}Type.swift` - Main type enum
2. `{Model}Action.swift` - Action enum
3. `{Model}Style.swift` - Style enum
4. Optional: Model-specific types (e.g., BarButton, MenuItem)

### collections/ (3 files)
1. `ActionsSet.swift` - Set<{Model}Action>
2. `MetadataDictionary.swift` - [String: Any]
3. `{Model}Array.swift` - [{Model}] with collection methods

### attributes/ (4 files)
Standard pattern:
1. `Alignment.swift` - Alignment properties
2. `Position.swift` or `Size.swift` or `Format.swift` - Layout/size properties
3. `State.swift` - State management
4. `Visibility.swift` or `Variant.swift` or `ColorScheme.swift` - Visual properties

### strings/ (3-4 plain text files)
Standard naming:
1. `DefaultTitle.swift` - Default title text
2. `PlaceholderText.swift` - Placeholder/empty state text
3. `ErrorMessages.swift` - Error message text
4. Optional: Model-specific strings (ButtonLabels, EmptyState, etc.)

## Model-Specific Properties (Optional)

These properties are intentionally different per model based on their UI purpose:

### properties/content/
- **BarModel**: title, icon
- **PanelModel**: title, body
- **CardModel**: title, subtitle, body, icon
- **TabModel**: label, icon
- **ControlModel**: label, value
- **DisplayModel**: data, value
- **MenuModel**: items

### properties/behavior/
- **BarModel**: canClose, canAutoHide
- **PanelModel**: canClose, canResize, canDetach
- **CardModel**: isSelectable
- **TabModel**: isSelected, canReorder, canClose
- **ControlModel**: showsFeedback, showsHover
- **DisplayModel**: autoRefresh
- **MenuModel**: dismissOnSelect, allowsMultipleSelection

## File Naming Conventions

1. **Properties**: lowercase, descriptive (e.g., `backgroundColor`, `padding`)
2. **Swift files**: PascalCase (e.g., `Create.swift`, `BarType.swift`)
3. **Types**: Match model prefix (e.g., `BarType`, `PanelAction`, `CardStyle`)
4. **Collections**: Descriptive suffix (e.g., `ActionsSet`, `BarsArray`)

## Platform Support

All Swift files must include @available annotations:
```swift
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
```

## Validation Rules

1. ✅ All core properties must exist
2. ✅ All 6 operations must exist
3. ✅ Minimum 3 types (Type, Action, Style)
4. ✅ All 3 collections must exist
5. ✅ 4 properties subdirectories must exist
6. ⚠️ Model-specific properties are optional but recommended
7. ⚠️ String file naming should follow DefaultTitle pattern

## Migration from Old Structure

Old plural directories (BarModels/, PanelModels/, etc.) contained sub-models:
- **BarModels/** → BreadcrumbsModel, PathBarModel, StatusBarModel, TitleBarModel, ToolBarModel
- **PanelModels/** → FloatingPanelModel, PreviewPanelModel, SidePanelModel
- **TabModels/** → TabsModel, VerticalTabsModel
- **etc.**

These should be **types** in the unified model, not separate models:
- BarModel with BarType enum: `.breadcrumbs`, `.path`, `.status`, `.title`, `.tool`
- PanelModel with PanelType enum: `.floating`, `.preview`, `.side`
- etc.

## Status

✅ **Fixed** (43 core properties added):
- All models now have complete layout properties (width, height, padding, spacing, position)
- All models now have complete style properties (backgroundColor, borderRadius, borderWidth, opacity, shadows)
- All models now have base behavior properties (isVisible, isEnabled, isInteractive)

⚠️ **Remaining** (23 model-specific properties):
- Content properties intentionally vary by model type
- Behavior flags intentionally vary by model purpose
- These differences are correct and expected

🔄 **Next Steps**:
1. Migrate sub-models from old BarModels/, PanelModels/ into types
2. Remove duplicate old directories
3. Apply pattern to /window/ViewModels
4. Apply pattern to /layout/components
5. Standardize /widow directory structure
