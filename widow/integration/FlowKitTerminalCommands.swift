import Foundation

/// Extended terminal commands for FlowKit operations
class FlowKitTerminalCommands: @unchecked Sendable {
    static let shared = FlowKitTerminalCommands()
    
    private let adapter = FlowKitAdapter.shared
    
    private init() {}
    
    func handleCommand(_ command: String) -> String {
        return execute(command)
    }
    
    func execute(_ command: String) -> String {
        let parts = command.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
        guard !parts.isEmpty else { return "Error: Empty command" }
        
        let cmd = parts[0].lowercased()
        
        do {
            switch cmd {
            // Kit commands
            case "list-kits", "ls-kits":
                return listKits()
                
            case "import-kit":
                guard parts.count >= 2 else { return "Usage: import-kit <KitName>" }
                try adapter.importKitAsPackage(parts[1])
                return "✓ Imported \(parts[1])"
                
            case "create-from-kit":
                guard parts.count >= 3 else { return "Usage: create-from-kit <KitName> <ProjectName>" }
                try adapter.createProjectFromKit(parts[1], projectName: parts[2])
                return "✓ Created project '\(parts[2])' from \(parts[1])"
                
            case "kit-info":
                guard parts.count >= 2 else { return "Usage: kit-info <KitName>" }
                return getKitInfo(parts[1])
                
            // Service commands
            case "list-services", "ls-services":
                adapter.loadAvailableServices()
                let services = adapter.activeServices
                return services.isEmpty ? "No services found" :
                    "Services:\n" + services.map { "  [\($0.category.rawValue)] \($0.name)" }.joined(separator: "\n")
                
            case "run-service":
                guard parts.count >= 2 else { return "Usage: run-service <ServiceName> [params]" }
                let result = try adapter.executeService(parts[1], with: [:])
                return result
                
            // View commands
            case "list-views", "ls-views":
                let views = adapter.loadAvailableViews()
                return views.isEmpty ? "No views found" :
                    "Views:\n" + views.map { "  [\($0.category.rawValue)] \($0.name)" }.joined(separator: "\n")
                
            // HIG commands
            case "list-hig", "ls-hig":
                let components = adapter.loadHIGComponents()
                return "HIG Components:\n" + components.map { "  - \($0.name)" }.joined(separator: "\n")
                
            // Workspace commands
            case "init-flowkit":
                try adapter.createFlowKitWorkspace()
                return "✓ FlowKit workspace initialized"
                
            case "flowkit-status":
                return getFlowKitStatus()
                
            // Unknown command
            default:
                return "Unknown FlowKit command: \(cmd). Type 'help' for available commands."
            }
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
    
    private func listKits() -> String {
        adapter.loadAvailableKits()
        let kits = adapter.availableKits
        
        guard !kits.isEmpty else { return "No kits found" }
        
        var output = "Available Kits:\n\n"
        
        // Group by type
        let grouped = Dictionary(grouping: kits, by: { $0.type })
        
        for (type, kitList) in grouped.sorted(by: { $0.key.rawValue < $1.key.rawValue }) {
            output += "[\(type.rawValue)]\n"
            for kit in kitList.sorted(by: { $0.name < $1.name }) {
                output += "  • \(kit.name)\n"
            }
            output += "\n"
        }
        
        return output
    }
    
    private func getKitInfo(_ kitName: String) -> String {
        let mapper = KitPackageMapper.shared
        let manifest = mapper.generateKitManifest(for: kitName)
        return manifest.displayInfo
    }
    
    private func getFlowKitStatus() -> String {
        adapter.loadAvailableKits()
        adapter.loadAvailableServices()
        
        let kitCount = adapter.availableKits.count
        let serviceCount = adapter.activeServices.count
        
        return """
        FlowKit Status:
        ═══════════════════════════════════
        Kits Available:    \(kitCount)
        Services Loaded:   \(serviceCount)
        HIG Components:    \(adapter.loadHIGComponents().count)
        Views Available:   \(adapter.loadAvailableViews().count)
        
        Quick Commands:
        • list-kits          - Show all kits
        • import-kit <name>  - Import kit as package
        • list-services      - Show all services
        • list-views         - Show all views
        """
    }
    
    var helpText: String {
        """
        FlowKit Commands:
        
        KIT MANAGEMENT:
          list-kits                      - List all available kits
          import-kit <KitName>           - Import kit as package
          create-from-kit <Kit> <Name>   - Create project from kit
          kit-info <KitName>             - Show kit details
        
        SERVICE OPERATIONS:
          list-services                  - List all services
          run-service <Name> [params]    - Execute a service
        
        VIEW OPERATIONS:
          list-views                     - List all views
        
        HIG OPERATIONS:
          list-hig                       - List HIG components
        
        WORKSPACE:
          init-flowkit                   - Initialize FlowKit workspace
          flowkit-status                 - Show FlowKit status
        
        Examples:
          list-kits
          import-kit AIKit
          create-from-kit ChatKit MyChatApp
          flowkit-status
        """
    }
}
