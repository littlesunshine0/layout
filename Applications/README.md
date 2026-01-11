# Applications Directory
Runtime & Distribution layer for compiled application bundles

## Purpose
Stores final, compiled application bundles (.app) with baked-in default window configurations.

## Usage
- Applications read initial state from their internal bundle
- Can dynamically hook into `/Projects/` or `/Packages/` for customization
- Use standard macOS app bundle structure

## Structure
Each .app bundle contains:
- Info.plist with window defaults
- Resources for initial configurations
- Runtime hooks to `/Projects/` for live editing
