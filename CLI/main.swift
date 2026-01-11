import Foundation

/// Simple CLI for FlowKit integration and CRUD operations
/// Works on Linux (no SwiftUI dependencies)

print("🚀 Layout CLI - FlowKit Integration Tool")
print("========================================\n")

let flowKit = FlowKitAdapter.shared
let flowKitCommands = FlowKitTerminalCommands.shared
let crudManager = CRUDManager.shared

func showHelp() {
    print("""
    Available Commands:
    
    FlowKit Commands:
      list-kits              - List all available FlowKit kits
      import-kit <name>      - Import a kit as a package
      create-from-kit <kit> <project> - Create project from kit
      list-services          - List all FlowKit services
      list-views             - List all FlowKit views
    
    CRUD Commands:
      list-projects          - List all projects
      list-packages          - List all packages
      create-project <name>  - Create a new project
      create-package <name>  - Create a new package
    
    Other:
      help                   - Show this help message
      quit                   - Exit the CLI
    
    """)
}

func processCommand(_ input: String) -> Bool {
    let parts = input.split(separator: " ").map(String.init)
    guard let command = parts.first else { return true }
    
    switch command.lowercased() {
    case "help":
        showHelp()
        
    case "list-kits":
        let result = flowKitCommands.handleCommand("list-kits")
        print(result)
        
    case "import-kit":
        guard parts.count > 1 else {
            print("❌ Usage: import-kit <kit-name>")
            return true
        }
        let result = flowKitCommands.handleCommand("import-kit \(parts[1])")
        print(result)
        
    case "create-from-kit":
        guard parts.count > 2 else {
            print("❌ Usage: create-from-kit <kit-name> <project-name>")
            return true
        }
        let result = flowKitCommands.handleCommand("create-from-kit \(parts[1]) \(parts[2])")
        print(result)
        
    case "list-services":
        let result = flowKitCommands.handleCommand("list-services")
        print(result)
        
    case "list-views":
        let result = flowKitCommands.handleCommand("list-views")
        print(result)
        
    case "list-projects":
        do {
            let projects = try crudManager.listProjects()
            if projects.isEmpty {
                print("📁 No projects found")
            } else {
                print("📁 Projects:")
                for project in projects {
                    print("  • \(project)")
                }
            }
        } catch {
            print("❌ Error: \(error.localizedDescription)")
        }
        
    case "list-packages":
        do {
            let packages = try crudManager.listPackages()
            if packages.isEmpty {
                print("📦 No packages found")
            } else {
                print("📦 Packages:")
                for package in packages {
                    print("  • \(package)")
                }
            }
        } catch {
            print("❌ Error: \(error.localizedDescription)")
        }
        
    case "create-project":
        guard parts.count > 1 else {
            print("❌ Usage: create-project <project-name>")
            return true
        }
        do {
            try crudManager.createProject(name: parts[1])
            print("✅ Created project: \(parts[1])")
        } catch {
            print("❌ Error: \(error.localizedDescription)")
        }
        
    case "create-package":
        guard parts.count > 1 else {
            print("❌ Usage: create-package <package-name>")
            return true
        }
        do {
            let properties = ["type": "custom", "version": "1.0"]
            try crudManager.createPackage(name: parts[1], properties: properties)
            print("✅ Created package: \(parts[1])")
        } catch {
            print("❌ Error: \(error.localizedDescription)")
        }
        
    case "quit", "exit":
        print("👋 Goodbye!")
        return false
        
    default:
        print("❌ Unknown command: \(command)")
        print("Type 'help' for available commands")
    }
    
    return true
}

// Main REPL loop
showHelp()

while true {
    print("\n> ", terminator: "")
    guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines),
          !input.isEmpty else {
        continue
    }
    
    if !processCommand(input) {
        break
    }
}
