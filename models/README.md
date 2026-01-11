# Models Directory Structure

## Unified Models (Canonical)
- BarModel/
- PanelModel/
- CardModel/
- TabModel/
- ControlModel/
- DisplayModel/
- MenuModel/

These follow the canonical pattern described in PATTERN_DEFINITION.md.

## Legacy Sub-Model Collections (Plural)
- BarModels/
- PanelModels/
- TabModels/
- ControlModels/
- DisplayModels/
- MenuModels/

These contain legacy or specialized sub-models (e.g., TitleBarModel, FloatingPanelModel, etc.).

## Integration Pattern
- Each unified model references its sub-models/types from the corresponding plural directory.
- Example: BarModel/types/BarType.swift includes cases for each sub-model in BarModels/ (e.g., .title, .path, .status, .breadcrumbs, .toolbar).
- This allows both granular and unified usage patterns.

## Migration/Refactoring Guidance
- When adding new subtypes, update both the unified model’s type enum and the plural directory as needed.
- Legacy sub-models can be refactored into the unified model structure over time, or kept for backward compatibility.
