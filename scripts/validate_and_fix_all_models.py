#!/usr/bin/env python3
"""
Validate and auto-correct all unified models and plural sub-models to match the canonical pattern.
Run this script anytime to enforce structure and file count across all models.
"""
import os
from pathlib import Path

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

PLURAL_DIRS = [
    "BarModels", "PanelModels", "TabModels", "ControlModels", "DisplayModels", "MenuModels"
]

UNIFIED_MODELS = [
    "BarModel", "PanelModel", "CardModel", "TabModel", "ControlModel", "DisplayModel", "MenuModel"
]

MODELS_PATH = Path("/workspaces/layout/models")

def ensure_pattern(model_path: Path):
    changed = False
    for relpath in CANONICAL_STRUCTURE:
        target = model_path / relpath
        target.parent.mkdir(parents=True, exist_ok=True)
        ext = Path(relpath).suffix
        content = DEFAULT_CONTENT.get(ext, DEFAULT_CONTENT[""])
        if not target.exists():
            target.write_text(content)
            print(f"  ✓ Created {target.relative_to(MODELS_PATH)}")
            changed = True
    return changed

def validate_and_fix():
    print("\n=== Validating Unified Models ===")
    for model in UNIFIED_MODELS:
        model_path = MODELS_PATH / model
        if not model_path.exists():
            continue
        print(f"\n{model}/")
        ensure_pattern(model_path)

    print("\n=== Validating Plural Sub-Models ===")
    for plural_dir in PLURAL_DIRS:
        plural_path = MODELS_PATH / plural_dir
        if not plural_path.exists():
            continue
        for submodel in plural_path.iterdir():
            if not submodel.is_dir():
                continue
            print(f"\n{plural_dir}/{submodel.name}/")
            ensure_pattern(submodel)

if __name__ == "__main__":
    validate_and_fix()
    print("\nPattern validation and correction complete.")
