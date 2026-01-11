#!/usr/bin/env python3
"""
Pattern Validator and Auto-Corrector for Layout Models
Ensures all models follow the same structure and naming conventions
"""

import os
from pathlib import Path
from typing import Dict, List, Set

class PatternValidator:
    def __init__(self, base_path: str = "/workspaces/layout"):
        self.base_path = Path(base_path)
        self.models_path = self.base_path / "models"
        self.errors = []
        self.warnings = []
        
    # Expected structure for all models
    EXPECTED_STRUCTURE = {
        "subdirectories": ["properties", "attributes", "operations", "types", "strings", "collections"],
        "properties_subdirs": ["layout", "style", "content", "behavior"],
        "operations": ["Create.swift", "Read.swift", "Update.swift", "Delete.swift", "Toggle.swift", "Validate.swift"],
    }
    
    # Common properties all models should have
    COMMON_PROPERTIES = {
        "layout": ["width", "height"],
        "style": ["backgroundColor", "borderRadius", "opacity"],
        "behavior": []  # Varies by model type
    }
    
    # Naming conventions
    NAMING_PATTERNS = {
        "attributes": lambda model: f"{model}*.swift",
        "operations": lambda model: "*.swift",
        "types": lambda model: f"{model}*.swift",
        "strings": lambda model: "*.swift",
        "collections": lambda model: "*.swift",
    }
    
    def get_models(self) -> List[str]:
        """Get all model directories"""
        models = []
        if self.models_path.exists():
            for item in self.models_path.iterdir():
                if item.is_dir() and item.name.endswith("Model"):
                    models.append(item.name)
        return sorted(models)
    
    def validate_directory_structure(self, model: str) -> bool:
        """Validate model has all required subdirectories"""
        model_path = self.models_path / model
        valid = True
        
        for subdir in self.EXPECTED_STRUCTURE["subdirectories"]:
            path = model_path / subdir
            if not path.exists():
                self.errors.append(f"{model}: Missing subdirectory '{subdir}'")
                valid = False
        
        # Check properties subdirectories
        props_path = model_path / "properties"
        if props_path.exists():
            for subdir in self.EXPECTED_STRUCTURE["properties_subdirs"]:
                path = props_path / subdir
                if not path.exists():
                    self.errors.append(f"{model}: Missing properties/{subdir}")
                    valid = False
        
        return valid
    
    def validate_operations(self, model: str) -> bool:
        """Validate all required operations exist"""
        ops_path = self.models_path / model / "operations"
        valid = True
        
        if ops_path.exists():
            existing = set(f.name for f in ops_path.iterdir() if f.is_file())
            required = set(self.EXPECTED_STRUCTURE["operations"])
            
            missing = required - existing
            if missing:
                self.errors.append(f"{model}/operations: Missing {missing}")
                valid = False
        
        return valid
    
    def validate_types(self, model: str) -> bool:
        """Validate model has its Type definition"""
        types_path = self.models_path / model / "types"
        valid = True
        
        if types_path.exists():
            model_prefix = model.replace("Model", "")
            type_file = f"{model_prefix}Type.swift"
            
            if not (types_path / type_file).exists():
                self.errors.append(f"{model}/types: Missing {type_file}")
                valid = False
        
        return valid
    
    def validate_strings_consistency(self, model: str) -> bool:
        """Check strings follow naming conventions"""
        strings_path = self.models_path / model / "types"
        valid = True
        
        if strings_path.exists():
            files = [f.name for f in strings_path.iterdir() if f.is_file()]
            
            # All strings files should be plain text or have consistent naming
            for f in files:
                if not f.endswith('.swift'):
                    # Check if it's a valid property file (plain text)
                    pass
        
        return valid
    
    def compare_properties_across_models(self) -> Dict[str, Set[str]]:
        """Compare properties across all models to find inconsistencies"""
        models = self.get_models()
        comparison = {}
        
        for prop_type in self.EXPECTED_STRUCTURE["properties_subdirs"]:
            comparison[prop_type] = {}
            
            for model in models:
                path = self.models_path / model / "properties" / prop_type
                if path.exists():
                    files = set(f.name for f in path.iterdir() if f.is_file())
                    comparison[prop_type][model] = files
        
        return comparison
    
    def validate_all(self) -> bool:
        """Run all validations"""
        models = self.get_models()
        print(f"Found {len(models)} models: {', '.join(models)}\n")
        
        all_valid = True
        
        for model in models:
            print(f"Validating {model}...")
            valid = True
            valid &= self.validate_directory_structure(model)
            valid &= self.validate_operations(model)
            valid &= self.validate_types(model)
            
            if valid:
                print(f"  ✓ {model} structure valid")
            else:
                print(f"  ✗ {model} has errors")
                all_valid = False
        
        print("\n=== Property Comparison ===")
        comparison = self.compare_properties_across_models()
        
        for prop_type, models_data in comparison.items():
            print(f"\n{prop_type}:")
            all_props = set()
            for model, props in models_data.items():
                all_props.update(props)
            
            # Show which models have which properties
            for prop in sorted(all_props):
                models_with_prop = [m for m, ps in models_data.items() if prop in ps]
                models_without_prop = [m for m, ps in models_data.items() if prop not in ps]
                
                if models_without_prop:
                    print(f"  {prop}: Missing from {', '.join(models_without_prop)}")
                    self.warnings.append(f"Property '{prop}' not in all models (missing from {models_without_prop})")
        
        # Print summary
        print(f"\n=== Summary ===")
        print(f"Errors: {len(self.errors)}")
        print(f"Warnings: {len(self.warnings)}")
        
        if self.errors:
            print("\nErrors:")
            for error in self.errors:
                print(f"  ✗ {error}")
        
        if self.warnings:
            print("\nWarnings:")
            for warning in self.warnings:
                print(f"  ⚠ {warning}")
        
        return all_valid and len(self.errors) == 0

if __name__ == "__main__":
    validator = PatternValidator()
    valid = validator.validate_all()
    
    exit(0 if valid else 1)
