import Foundation

/// Terminal command handler for CRUD operations
class TerminalHandler {
    private let crud = CRUDManager.shared
    private lazy var flowKitCommands = FlowKitTerminalCommands()
    
    func execute(_ command: String) -> String {
        // Check if it's a FlowKit-specific command first
        if command.starts(with: "flowkit") || 
           command.contains("kit") || 
           command.contains("service") ||
           command.starts(with: "list-kits") ||
           command.starts(with: "import-kit") {
            return flowKitCommands.execute(command)
        }
        
        return executeStandard(command)
    }
    
    private func executeStandard(_ command: String) -> String {
        let parts = command.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
        guard !parts.isEmpty else { return "Error: Empty command" }
        
        let cmd = parts[0].lowercased()
        
        do {
            switch cmd {
            // Project commands
            case "create-project":
                guard parts.count >= 2 else { return "Usage: create-project <name> [template]" }
                let name = parts[1]
                let template = parts.count > 2 ? parts[2] : nil
                try crud.createProject(name: name, template: template)
                return "✓ Project '\(name)' created"
                
            case "read-project", "show-project":
                guard parts.count >= 2 else { return "Usage: read-project <name>" }
                let info = try crud.readProject(name: parts[1])
                var output = "Project: \(info.name)\nPath: \(info.path)\nProperties:\n"
                for (key, value) in info.properties.sorted(by: { $0.key < $1.key }) {
                    output += "  \(key): \(value)\n"
                }
                return output
                
            case "update-project":
                guard parts.count >= 4 else { return "Usage: update-project <name> <property> <value>" }
                try crud.updateProject(name: parts[1], property: parts[2], value: parts[3...].joined(separator: " "))
                return "✓ Updated \(parts[1])/\(parts[2])"
                
            case "delete-project":
                guard parts.count >= 2 else { return "Usage: delete-project <name>" }
                try crud.deleteProject(name: parts[1])
                return "✓ Project '\(parts[1])' deleted"
                
            case "list-projects", "ls-projects":
                let projects = try crud.listProjects()
                return projects.isEmpty ? "No projects found" : "Projects:\n" + projects.map { "  - \($0)" }.joined(separator: "\n")
                
            // Package commands
            case "create-package":
                guard parts.count >= 2 else { return "Usage: create-package <name>" }
                try crud.createPackage(name: parts[1], properties: [:])
                return "✓ Package '\(parts[1])' created"
                
            case "read-package", "show-package":
                guard parts.count >= 2 else { return "Usage: read-package <name>" }
                let content = try crud.readPackage(name: parts[1])
                return content
                
            case "update-package":
                guard parts.count >= 4 else { return "Usage: update-package <name> <property> <value>" }
                try crud.updatePackage(name: parts[1], property: parts[2], value: parts[3...].joined(separator: " "))
                return "✓ Updated package \(parts[1])"
                
            case "delete-package":
                guard parts.count >= 2 else { return "Usage: delete-package <name>" }
                try crud.deletePackage(name: parts[1])
                return "✓ Package '\(parts[1])' deleted"
                
            case "list-packages", "ls-packages":
                let packages = try crud.listPackages()
                return packages.isEmpty ? "No packages found" : "Packages:\n" + packages.map { "  - \($0)" }.joined(separator: "\n")
                
            // Swift file commands
            case "create-swift":
                guard parts.count >= 4 else { return "Usage: create-swift <project> <path> <name>" }
                let defaultContent = "import Foundation\n\n// \(parts[3])\n"
                try crud.createSwiftFile(project: parts[1], path: parts[2], name: parts[3], content: defaultContent)
                return "✓ Created \(parts[1])/\(parts[2])/\(parts[3]).swift"
                
            case "read-swift", "cat-swift":
                guard parts.count >= 4 else { return "Usage: read-swift <project> <path> <name>" }
                let content = try crud.readSwiftFile(project: parts[1], path: parts[2], name: parts[3])
                return content
                
            case "delete-swift", "rm-swift":
                guard parts.count >= 4 else { return "Usage: delete-swift <project> <path> <name>" }
                try crud.deleteSwiftFile(project: parts[1], path: parts[2], name: parts[3])
                return "✓ Deleted \(parts[1])/\(parts[2])/\(parts[3]).swift"
                
            // File write (original functionality)
            case "echo":
                return handleEcho(parts: Array(parts.dropFirst()))
                
            case "help", "?":
                return helpText
                
            default:
                return "Unknown command: \(cmd)\nType 'help' for available commands"
            }
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
    
    private func handleEcho(parts: [String]) -> String {
        guard let redirectIndex = parts.firstIndex(of: ">"), redirectIndex > 0 else {
            return parts.joined(separator: " ")
        }
        
        let value = parts[..<redirectIndex].joined(separator: " ").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "\"", with: "")
        let file = parts[(redirectIndex + 1)...].joined(separator: " ")
        
        // Assume writing to current project's properties
        do {
            try crud.updateProject(name: "MyNewApp", property: file, value: value)
            return "✓ Wrote to \(file)"
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
    
    private var helpText: String {
        """
        Available Commands:
        
        PROJECT OPERATIONS:
          create-project <name> [template]  - Create new project
          read-project <name>               - Show project info
          update-project <name> <prop> <val> - Update property
          delete-project <name>             - Delete project
          list-projects                     - List all projects
        
        PACKAGE OPERATIONS:
          create-package <name>             - Create new package
          read-package <name>               - Show package content
          update-package <name> <prop> <val> - Update package
          delete-package <name>             - Delete package
          list-packages                     - List all packages
        
        SWIFT FILE OPERATIONS:
          create-swift <proj> <path> <name> - Create Swift file
          read-swift <proj> <path> <name>   - Read Swift file
          delete-swift <proj> <path> <name> - Delete Swift file
        
        OTHER:
          echo <value> > <file>             - Write to property file
          help                              - Show this help
        
        Examples:
          create-project MyApp InspectorWindow
          update-project MyApp WindowTitle "My Window"
          echo "0.5" > WindowAlphaValue
          list-projects
        """
    }
}
