#!/usr/bin/env python3
"""
Classify and validate layout/components subfolders as UI components or not.
Enforce canonical pattern for UI components, and keep models/ separate.
"""
import os
from pathlib import Path

COMPONENTS_PATH = Path("/workspaces/layout/layout/components")
UI_COMPONENTS = [
    "card", "category", "content", "navigation", "panel", "pathbar", "platform",
    "previewpanel", "statusbar", "tabs", "titlebar"
]

CANONICAL_STRUCTURE = [
    "attributes/Alignment.swift",
    "attributes/Position.swift",
    "attributes/State.swift",
    "attributes/Visibility.swift",
    "collections/ActionsSet.swift",
    "collections/MetadataDictionary.swift",
    "collections/ModelArray.swift",
    "operations/Create.swift",
    "operations/Read.swift",
    "operations/Update.swift",
    "operations/Delete.swift",
    "operations/Toggle.swift",
    "operations/Validate.swift",
    "properties/layout/width",
    "properties/layout/height",
    "properties/layout/padding",
    "properties/layout/spacing",
    "properties/layout/position",
    "properties/style/backgroundColor",
    "properties/style/borderRadius",
    "properties/style/borderWidth",
    "properties/style/opacity",
    "properties/style/shadowOffset",
    "properties/style/shadowOpacity",
    "properties/content/title",
    "properties/content/body",
    "properties/content/icon",
    "properties/content/value",
    "properties/behavior/isVisible",
    "properties/behavior/isEnabled",
    "properties/behavior/isInteractive",
    "strings/DefaultTitle.swift",
    "strings/PlaceholderText.swift",
    "strings/ErrorMessages.swift",
    "types/ModelType.swift",
    "types/ModelAction.swift",
    "types/ModelStyle.swift"
]

DEFAULT_CONTENT = {
    ".swift": "// ...\n",
    "": "default\n"
}

def ensure_pattern(component_path: Path):
    changed = False
    for relpath in CANONICAL_STRUCTURE:
        target = component_path / relpath
        target.parent.mkdir(parents=True, exist_ok=True)
        ext = Path(relpath).suffix
        content = DEFAULT_CONTENT.get(ext, DEFAULT_CONTENT[""])
        if not target.exists():
            target.write_text(content)
            print(f"  ✓ Created {target.relative_to(component_path)} in {component_path.name}")
            changed = True
    return changed

def classify_and_validate():
    print("\n=== Classifying and Validating layout/components ===")
    for sub in COMPONENTS_PATH.iterdir():
        if not sub.is_dir():
            continue
        if sub.name == "models":
            print(f"\n{sub.name}/ (NOT a UI component, skip pattern enforcement)")
            continue
        if sub.name in UI_COMPONENTS:
            print(f"\n{sub.name}/ (UI component)")
            ensure_pattern(sub)
        else:
            print(f"\n{sub.name}/ (Unknown, treat as non-component)")

if __name__ == "__main__":
    classify_and_validate()
    print("\nClassification and validation complete.")
