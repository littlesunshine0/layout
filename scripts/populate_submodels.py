#!/usr/bin/env python3
"""
Populate all empty sub-models in plural directories with the canonical pattern.
Each sub-model will get the same subfolders and files as its parent unified model.
"""
import os
import shutil
from pathlib import Path

# Canonical subfolders and files (relative to model root)
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

# Default content for each file type
DEFAULT_CONTENT = {
    ".swift": "// ...\n",
    "": "default\n"
}

PLURAL_DIRS = [
    "BarModels", "PanelModels", "TabModels", "ControlModels", "DisplayModels", "MenuModels"
]

MODELS_PATH = Path("/workspaces/layout/models")

for plural_dir in PLURAL_DIRS:
    plural_path = MODELS_PATH / plural_dir
    if not plural_path.exists():
        continue
    for submodel in plural_path.iterdir():
        if not submodel.is_dir():
            continue
        # Check if submodel is empty or missing canonical structure
        existing_files = list(submodel.rglob("*"))
        if len([f for f in existing_files if f.is_file()]) > 0:
            continue  # Skip non-empty
        print(f"Populating {submodel.relative_to(MODELS_PATH)}...")
        for relpath in CANONICAL_STRUCTURE:
            target = submodel / relpath
            target.parent.mkdir(parents=True, exist_ok=True)
            ext = Path(relpath).suffix
            content = DEFAULT_CONTENT.get(ext, DEFAULT_CONTENT[""])
            if not target.exists():
                target.write_text(content)
