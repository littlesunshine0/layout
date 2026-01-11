#!/usr/bin/env python3
"""
Comprehensive Pattern Enforcement Tool
Migrates old structures, applies pattern to all directories
"""

import os
import shutil
from pathlib import Path
from typing import List, Dict

class ComprehensivePatternEnforcer:
    def __init__(self, base_path: str = "/workspaces/layout"):
        self.base_path = Path(base_path)
        self.actions = []
        
    def list_old_submodels(self):
        """List all sub-models in old plural directories"""
        old_dirs = {
            "BarModels": [],
            "PanelModels": [],
            "TabModels": [],
            "ControlModels": [],
            "DisplayModels": [],
            "MenuModels": []
        }
        
        models_path = self.base_path / "models"
        
        for old_dir_name in old_dirs.keys():
            old_path = models_path / old_dir_name
            if old_path.exists():
                for item in old_path.iterdir():
                    if item.is_dir() and item.name.endswith("Model"):
                        old_dirs[old_dir_name].append(item.name)
        
        return old_dirs
    
    def analyze_directory_patterns(self, path: Path) -> Dict[str, any]:
        """Analyze a directory's structure"""
        if not path.exists():
            return {"exists": False}
        
        analysis = {
            "exists": True,
            "is_dir": path.is_dir(),
            "subdirs": [],
            "files": [],
            "has_model_pattern": False
        }
        
        if path.is_dir():
            for item in path.iterdir():
                if item.is_dir():
                    analysis["subdirs"].append(item.name)
                else:
                    analysis["files"].append(item.name)
            
            # Check if it follows model pattern
            expected_subdirs = {"properties", "attributes", "operations", "types", "strings", "collections"}
            if expected_subdirs.issubset(set(analysis["subdirs"])):
                analysis["has_model_pattern"] = True
        
        return analysis
    
    def scan_workspace(self):
        """Scan entire workspace for directories needing pattern enforcement"""
        print("=== Workspace Structure Analysis ===\n")
        
        # Analyze /models
        print("📁 /models/")
        models_path = self.base_path / "models"
        if models_path.exists():
            for item in sorted(models_path.iterdir()):
                if item.is_dir():
                    analysis = self.analyze_directory_patterns(item)
                    icon = "✓" if analysis.get("has_model_pattern") else "✗"
                    suffix = " (unified)" if item.name.endswith("Model") and not item.name.endswith("Models") else " (old)"
                    print(f"  {icon} {item.name}{suffix}")
        
        # Analyze /window
        print("\n📁 /window/")
        window_path = self.base_path / "window"
        if window_path.exists():
            for item in sorted(window_path.iterdir()):
                if item.is_dir():
                    print(f"  → {item.name}/")
                else:
                    print(f"  → {item.name}")
        
        # Analyze /widow
        print("\n📁 /widow/")
        widow_path = self.base_path / "widow"
        if widow_path.exists():
            for item in sorted(widow_path.iterdir()):
                if item.is_dir():
                    print(f"  → {item.name}/")
        
        # Analyze /layout/components
        print("\n📁 /layout/components/")
        components_path = self.base_path / "layout" / "components"
        if components_path.exists():
            for item in sorted(components_path.iterdir()):
                if item.is_dir():
                    analysis = self.analyze_directory_patterns(item)
                    icon = "✓" if analysis.get("has_model_pattern") else "→"
                    print(f"  {icon} {item.name}/")
    
    def create_migration_plan(self):
        """Create plan for migrating old sub-models"""
        print("\n=== Migration Plan ===\n")
        
        old_submodels = self.list_old_submodels()
        
        mapping = {
            "BarModels": {
                "parent": "BarModel",
                "types": {
                    "BreadcrumbsModel": "breadcrumbs",
                    "PathBarModel": "path",
                    "StatusBarModel": "status",
                    "TitleBarModel": "title",
                    "ToolBarModel": "tool"
                }
            },
            "PanelModels": {
                "parent": "PanelModel",
                "types": {
                    "FloatingPanelModel": "floating",
                    "PreviewPanelModel": "preview",
                    "SidePanelModel": "side",
                    "CategoryPanelModel": "category"
                }
            },
            "TabModels": {
                "parent": "TabModel",
                "types": {
                    "TabsModel": "horizontal",
                    "VerticalTabsModel": "vertical"
                }
            },
            "ControlModels": {
                "parent": "ControlModel",
                "types": {
                    "AccordionModel": "accordion",
                    "ButtonsModel": "button",
                    "ChipsModel": "chip",
                    "SegmentedControlModel": "segmented",
                    "StepperModel": "stepper",
                    "TogglesModel": "toggle"
                }
            },
            "DisplayModels": {
                "parent": "DisplayModel",
                "types": {
                    "BadgesModel": "badge",
                    "ChartsModel": "chart",
                    "FeedModel": "feed",
                    "WidgetsModel": "widget"
                }
            },
            "MenuModels": {
                "parent": "MenuModel",
                "types": {
                    "BentoModel": "bento",
                    "ContextModel": "context",
                    "HamburgerModel": "hamburger"
                }
            }
        }
        
        for old_dir, config in mapping.items():
            if old_dir in old_submodels and old_submodels[old_dir]:
                print(f"📦 {old_dir}/ → {config['parent']}/")
                for submodel in old_submodels[old_dir]:
                    type_name = config['types'].get(submodel, "unknown")
                    print(f"   • {submodel} → BarType.{type_name}")
        
        return mapping
    
    def create_cleanup_plan(self):
        """Create plan for cleaning up old directories"""
        print("\n=== Cleanup Plan ===\n")
        
        old_dirs = ["BarModels", "PanelModels", "TabModels", "ControlModels", "DisplayModels", "MenuModels"]
        models_path = self.base_path / "models"
        
        to_remove = []
        for old_dir in old_dirs:
            path = models_path / old_dir
            if path.exists():
                to_remove.append(path)
                print(f"🗑️  Remove: /models/{old_dir}/")
        
        return to_remove
    
    def execute_cleanup(self, dry_run: bool = True):
        """Execute cleanup of old directories"""
        to_remove = self.create_cleanup_plan()
        
        if not to_remove:
            print("\n✓ No old directories to remove")
            return
        
        if dry_run:
            print(f"\n[DRY RUN] Would remove {len(to_remove)} directories")
        else:
            print(f"\n🗑️  Removing {len(to_remove)} old directories...")
            for path in to_remove:
                try:
                    # Create backup first
                    backup_path = path.parent / f"{path.name}.backup"
                    if not backup_path.exists():
                        shutil.move(str(path), str(backup_path))
                        print(f"   ✓ Moved {path.name} → {path.name}.backup")
                except Exception as e:
                    print(f"   ✗ Error backing up {path.name}: {e}")

if __name__ == "__main__":
    import sys
    
    enforcer = ComprehensivePatternEnforcer()
    
    if "--scan" in sys.argv:
        enforcer.scan_workspace()
    
    if "--migration-plan" in sys.argv:
        enforcer.create_migration_plan()
    
    if "--cleanup" in sys.argv:
        dry_run = "--dry-run" in sys.argv
        enforcer.execute_cleanup(dry_run=dry_run)
    
    if len(sys.argv) == 1:
        # Default: show everything
        enforcer.scan_workspace()
        enforcer.create_migration_plan()
        enforcer.execute_cleanup(dry_run=True)
