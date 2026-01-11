#!/usr/bin/env python3
"""
Pattern Auto-Corrector for Layout Models
Adds missing properties to ensure all models follow the same pattern
"""

import os
from pathlib import Path
from typing import Dict, List, Set

class PatternFixer:
    def __init__(self, base_path: str = "/workspaces/layout"):
        self.base_path = Path(base_path)
        self.models_path = self.base_path / "models"
        self.fixes_applied = []
        
    # Core properties ALL models should have
    CORE_PROPERTIES = {
        "layout": {
            "width": "auto",
            "height": "auto",
            "padding": "8",
            "spacing": "4",
            "position": "relative"
        },
        "style": {
            "backgroundColor": "#FFFFFF",
            "borderRadius": "4",
            "borderWidth": "1",
            "opacity": "1.0",
            "shadowOffset": "0,2",
            "shadowOpacity": "0.1"
        },
        "behavior": {
            "isVisible": "true",
            "isEnabled": "true",
            "isInteractive": "true"
        }
    }
    
    # Optional properties that are model-specific (keep if exists, don't force)
    OPTIONAL_PROPERTIES = {
        "style": ["selectionColor"],
        "content": ["body", "data", "icon", "items", "label", "subtitle", "text", "title", "value"],
        "behavior": [
            "allowsMultipleSelection", "autoRefresh", "canAutoHide", "canClose",
            "canDetach", "canReorder", "canResize", "dismissOnSelect",
            "isAnimated", "isSelectable", "isSelected", "showsFeedback", "showsHover"
        ]
    }
    
    def get_models(self) -> List[str]:
        """Get all model directories"""
        models = []
        if self.models_path.exists():
            for item in self.models_path.iterdir():
                if item.is_dir() and item.name.endswith("Model"):
                    models.append(item.name)
        return sorted(models)
    
    def get_existing_properties(self, model: str, category: str) -> Set[str]:
        """Get list of existing property files in a category"""
        path = self.models_path / model / "properties" / category
        if not path.exists():
            return set()
        return set(f.stem for f in path.iterdir() if f.is_file())
    
    def add_missing_property(self, model: str, category: str, prop_name: str, default_value: str) -> bool:
        """Add a missing property file"""
        path = self.models_path / model / "properties" / category / prop_name
        
        if path.exists():
            return False  # Already exists
        
        try:
            path.write_text(default_value)
            self.fixes_applied.append(f"Added {model}/properties/{category}/{prop_name}")
            return True
        except Exception as e:
            print(f"Error adding {model}/properties/{category}/{prop_name}: {e}")
            return False
    
    def fix_core_properties(self, model: str):
        """Ensure model has all core properties"""
        for category, properties in self.CORE_PROPERTIES.items():
            existing = self.get_existing_properties(model, category)
            
            for prop_name, default_value in properties.items():
                if prop_name not in existing:
                    self.add_missing_property(model, category, prop_name, default_value)
    
    def analyze_model_specific_properties(self, model: str) -> Dict[str, List[str]]:
        """Identify which optional properties this model should have based on its type"""
        model_type = model.replace("Model", "")
        recommendations = {}
        
        # Smart defaults based on model type
        if model_type == "Bar":
            recommendations["content"] = ["title", "icon"]
            recommendations["behavior"] = ["canClose", "canAutoHide"]
        elif model_type == "Panel":
            recommendations["content"] = ["title", "body"]
            recommendations["behavior"] = ["canClose", "canResize", "canDetach"]
        elif model_type == "Card":
            recommendations["content"] = ["title", "subtitle", "body", "icon"]
            recommendations["behavior"] = ["isSelectable"]
        elif model_type == "Tab":
            recommendations["content"] = ["label", "icon"]
            recommendations["behavior"] = ["isSelected", "canReorder", "canClose"]
        elif model_type == "Control":
            recommendations["content"] = ["label", "value"]
            recommendations["behavior"] = ["showsFeedback", "showsHover"]
        elif model_type == "Display":
            recommendations["content"] = ["data", "value"]
            recommendations["behavior"] = ["autoRefresh"]
        elif model_type == "Menu":
            recommendations["content"] = ["items"]
            recommendations["behavior"] = ["dismissOnSelect", "allowsMultipleSelection"]
        
        return recommendations
    
    def fix_all_models(self, dry_run: bool = False):
        """Fix all models"""
        models = self.get_models()
        print(f"Found {len(models)} models to fix\n")
        
        for model in models:
            print(f"Fixing {model}...")
            
            if not dry_run:
                # Add core properties
                self.fix_core_properties(model)
                
                # Get recommendations for model-specific properties
                recommendations = self.analyze_model_specific_properties(model)
                
                # Report what was recommended but not added (user can add manually)
                for category, props in recommendations.items():
                    existing = self.get_existing_properties(model, category)
                    for prop in props:
                        if prop not in existing:
                            print(f"  ℹ Recommended: {category}/{prop} (not auto-added)")
            else:
                print(f"  [DRY RUN] Would fix core properties for {model}")
        
        print(f"\n=== Summary ===")
        print(f"Fixes applied: {len(self.fixes_applied)}")
        
        if self.fixes_applied:
            print("\nFixed:")
            for fix in self.fixes_applied:
                print(f"  ✓ {fix}")
    
    def verify_fixes(self):
        """Re-run validation to confirm fixes"""
        print("\n=== Verifying Fixes ===")
        from validate_pattern import PatternValidator
        validator = PatternValidator()
        valid = validator.validate_all()
        return valid

if __name__ == "__main__":
    import sys
    
    dry_run = "--dry-run" in sys.argv
    
    fixer = PatternFixer()
    fixer.fix_all_models(dry_run=dry_run)
    
    if not dry_run:
        print("\n" + "="*50)
        fixer.verify_fixes()
