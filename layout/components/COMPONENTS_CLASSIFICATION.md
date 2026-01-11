# Components Classification: layout/components

## True UI Components (Canonical Pattern)
- card
- category
- content
- navigation
- panel
- pathbar
- platform
- previewpanel
- statusbar
- tabs
- titlebar

**Pattern:**
- All have: types/, collections/, attributes/, operations/, strings/, properties/ (with layout/, style/, content/, behavior/)
- May include: ViewModel, Model, Editor, Preview, Generator, Icons, etc.
- Many have extra property files for component-specific features

## Not a Component (Model/Data Logic)
- models

**Pattern:**
- Contains plural model directories (PanelModels, DisplayModels, BarModels, etc.)
- Contains sub-models, types, and properties for data/model logic, not UI rendering
- Also includes a README.md and some canonical pattern files

---

**How to use:**
- Only folders in the UI Components list should be treated as visual components for rendering, theming, or UI logic.
- The models/ folder is for data/model logic and should be handled separately.
