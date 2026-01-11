#!/usr/bin/env python3
"""
Validate and auto-correct all relevant directories in the workspace to match the canonical pattern.
This includes /models, /window/Models, /window/ViewModels, /layout/components/*, and /widow/*.
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

# Directories to enforce pattern on
EXTRA_DIRS = [
    Path("/workspaces/layout/window/Models"),
    Path("/workspaces/layout/window/ViewModels")
]

COMPONENTS_DIR = Path("/workspaces/layout/layout/components")
WIDOW_DIR = Path("/workspaces/layout/widow")

# Add all subdirs in /layout/components
for sub in COMPONENTS_DIR.iterdir():
    if sub.is_dir():
        EXTRA_DIRS.append(sub)

# Add all subdirs in /widow
for sub in WIDOW_DIR.iterdir():
    if sub.is_dir():
        EXTRA_DIRS.append(sub)

def ensure_pattern(model_path: Path):
    changed = False
    for relpath in CANONICAL_STRUCTURE:
        target = model_path / relpath
        target.parent.mkdir(parents=True, exist_ok=True)
        ext = Path(relpath).suffix
        content = DEFAULT_CONTENT.get(ext, DEFAULT_CONTENT[""])
        if not target.exists():
            target.write_text(content)
            print(f"  ✓ Created {target.relative_to(model_path)} in {model_path.relative_to(Path('/workspaces/layout'))}")
            changed = True
    return changed

def validate_and_fix_workspace():
    print("\n=== Validating and Fixing Workspace Directories ===")
    for d in EXTRA_DIRS:
        if not d.exists():
            continue
        print(f"\n{d.relative_to(Path('/workspaces/layout'))}/")
        ensure_pattern(d)

if __name__ == "__main__":
    validate_and_fix_workspace()
    print("\nWorkspace pattern validation and correction complete.")
