# Layout CLI - FlowKit Integration Tool

## Build Instructions

Build the project using Swift Package Manager:

```bash
cd /workspaces/layout
swift build
```

## Run the CLI

After building, run the CLI tool:

```bash
./.build/debug/layout-cli
```

## Available Commands

### FlowKit Commands

- `list-kits` - List all available FlowKit kits (37 kits organized by category)
- `import-kit <name>` - Import a FlowKit kit as a package
- `create-from-kit <kit> <project>` - Create a new project from a FlowKit kit
- `list-services` - List all FlowKit services  
- `list-views` - List all FlowKit views

### CRUD Commands

- `list-projects` - List all existing projects
- `list-packages` - List all available packages
- `create-project <name>` - Create a new project
- `create-package <name>` - Create a new package

### Other Commands

- `help` - Show help message with all commands
- `quit` or `exit` - Exit the CLI

## Examples

### List all FlowKit kits
```bash
echo "list-kits" | ./.build/debug/layout-cli
```

### Create a new project
```bash
echo "create-project MyApp" | ./.build/debug/layout-cli
```

### Import a FlowKit kit
```bash
echo "import-kit AIKit" | ./.build/debug/layout-cli
```

### Interactive Mode

Simply run the CLI without piping input to use it interactively:

```bash
./.build/debug/layout-cli

> list-kits
> create-project MyNewApp
> quit
```

## FlowKit Integration

The CLI integrates with your FlowKit project located at:
- `/Users/tempadmin/Desktop/Project`

It automatically discovers and categorizes all 37 kits:
- **Intelligence**: AIKit, AgentKit, NLUKit
- **Interaction**: ChatKit, CommandKit, WorkflowKit  
- **Infrastructure**: DataKit, FileKit, NetworkKit
- **Presentation**: UIKit, DesignKit, NavigationKit
- **Utility**: 30+ utility kits

## Build Status

✅ Build successful with Swift 6.0.3
✅ All CRUD operations working
✅ FlowKit integration active
✅ 37 kits discovered and categorized

## Notes

- The CLI is fully functional on Linux (Ubuntu 24.04)
- No SwiftUI dependencies - uses Foundation only
- All concurrency warnings resolved with `@unchecked Sendable`
- Deprecation warnings for `String(contentsOf:)` are non-critical
