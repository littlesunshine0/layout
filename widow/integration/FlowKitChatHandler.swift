import Foundation

/// Natural language chat interface for FlowKit operations
class FlowKitChatHandler {
    private let adapter = FlowKitAdapter.shared
    private let baseHandler = ChatHandler()
    
    func process(_ message: String) -> String {
        let lowercased = message.lowercased()
        
        // Kit operations
        if lowercased.contains("kit") {
            return handleKitOperation(message: lowercased)
        }
        
        // Service operations
        if lowercased.contains("service") {
            return handleServiceOperation(message: lowercased)
        }
        
        // Workflow operations
        if lowercased.contains("workflow") {
            return handleWorkflowOperation(message: lowercased)
        }
        
        // View operations
        if lowercased.contains("view") || lowercased.contains("ui") {
            return handleViewOperation(message: lowercased)
        }
        
        // HIG operations
        if lowercased.contains("hig") || lowercased.contains("design system") {
            return handleHIGOperation(message: lowercased)
        }
        
        // Agent operations
        if lowercased.contains("agent") || lowercased.contains("ai") {
            return handleAgentOperation(message: lowercased)
        }
        
        // Delegate to base handler
        return baseHandler.process(message)
    }
    
    // MARK: - Kit Operations
    
    private func handleKitOperation(message: String) -> String {
        if message.contains("list") || message.contains("show") {
            adapter.loadAvailableKits()
            let kits = adapter.availableKits
            
            if message.contains("ai") || message.contains("intelligence") {
                let aiKits = kits.filter { $0.type == .intelligence }
                return "AI/Intelligence Kits:\n" + aiKits.map { "• \($0.name)" }.joined(separator: "\n")
            }
            
            if message.contains("chat") || message.contains("interaction") {
                let chatKits = kits.filter { $0.type == .interaction }
                return "Interaction Kits:\n" + chatKits.map { "• \($0.name)" }.joined(separator: "\n")
            }
            
            return "Available Kits (\(kits.count)):\n" + kits.prefix(10).map { "• \($0.name) [\($0.type.rawValue)]" }.joined(separator: "\n")
        }
        
        if message.contains("import") || message.contains("add") {
            if let kitName = extractKitName(from: message) {
                do {
                    try adapter.importKitAsPackage(kitName)
                    return "✓ Successfully imported \(kitName) as a package. You can now create projects using it!"
                } catch {
                    return "Failed to import \(kitName): \(error.localizedDescription)"
                }
            }
            return "Which kit would you like to import? Try: 'import AIKit'"
        }
        
        if message.contains("create") && message.contains("project") {
            if let kitName = extractKitName(from: message),
               let projectName = extractProjectName(from: message) {
                do {
                    try adapter.createProjectFromKit(kitName, projectName: projectName)
                    return "✓ Created project '\(projectName)' based on \(kitName)!"
                } catch {
                    return "Error: \(error.localizedDescription)"
                }
            }
            return "Specify: 'create a project called MyApp using ChatKit'"
        }
        
        return "I can help you list kits, import them, or create projects from them. What would you like to do?"
    }
    
    // MARK: - Service Operations
    
    private func handleServiceOperation(message: String) -> String {
        if message.contains("list") || message.contains("show") {
            adapter.loadAvailableServices()
            let services = adapter.activeServices
            
            if message.contains("ai") {
                let aiServices = services.filter { $0.category == .ai }
                return "AI Services:\n" + aiServices.map { "• \($0.name)" }.joined(separator: "\n")
            }
            
            if message.contains("workflow") {
                let workflowServices = services.filter { $0.category == .workflow }
                return "Workflow Services:\n" + workflowServices.map { "• \($0.name)" }.joined(separator: "\n")
            }
            
            let grouped = Dictionary(grouping: services.prefix(20), by: { $0.category })
            var output = "Available Services:\n\n"
            for (category, serviceList) in grouped {
                output += "[\(category.rawValue)]\n"
                for service in serviceList.prefix(5) {
                    output += "  • \(service.name)\n"
                }
            }
            return output
        }
        
        return "I can show you available services. Try: 'show me AI services'"
    }
    
    // MARK: - Workflow Operations
    
    private func handleWorkflowOperation(message: String) -> String {
        if message.contains("create") || message.contains("new") {
            return "To create a workflow, you can use WorkflowKit. Would you like me to import it?"
        }
        
        return "WorkflowKit provides powerful workflow automation. Try: 'import WorkflowKit'"
    }
    
    // MARK: - View Operations
    
    private func handleViewOperation(message: String) -> String {
        if message.contains("list") || message.contains("show") {
            let views = adapter.loadAvailableViews()
            
            if message.contains("chat") {
                let chatViews = views.filter { $0.category == .chat }
                return "Chat Views:\n" + chatViews.map { "• \($0.name)" }.joined(separator: "\n")
            }
            
            if message.contains("dashboard") {
                let dashboards = views.filter { $0.category == .dashboard }
                return "Dashboard Views:\n" + dashboards.map { "• \($0.name)" }.joined(separator: "\n")
            }
            
            let grouped = Dictionary(grouping: views.prefix(15), by: { $0.category })
            var output = "Available Views:\n\n"
            for (category, viewList) in grouped {
                output += "[\(category.rawValue)]\n"
                for view in viewList.prefix(3) {
                    output += "  • \(view.name)\n"
                }
            }
            return output
        }
        
        return "I can show you available views. Try: 'show me chat views'"
    }
    
    // MARK: - HIG Operations
    
    private func handleHIGOperation(message: String) -> String {
        if message.contains("list") || message.contains("show") || message.contains("components") {
            let components = adapter.loadHIGComponents()
            return "HIG Components:\n" + components.map { "• \($0.name)" }.joined(separator: "\n") +
                "\n\nHIG provides Apple's Human Interface Guidelines components for consistent design."
        }
        
        if message.contains("use") || message.contains("apply") {
            return "To use HIG components in your project, import the HIG module. Would you like me to set that up?"
        }
        
        return "HIG provides design system components. Try: 'show me HIG components'"
    }
    
    // MARK: - Agent Operations
    
    private func handleAgentOperation(message: String) -> String {
        if message.contains("what") || message.contains("explain") {
            return "AgentKit provides AI agent orchestration for your FlowKit project. It includes agent management, multi-agent workflows, and AI coordination."
        }
        
        if message.contains("create") || message.contains("setup") {
            return "To set up AI agents, import AgentKit: 'import AgentKit'. This will give you access to agent orchestration capabilities."
        }
        
        return "AgentKit enables AI-powered workflows. Try: 'explain what AgentKit does'"
    }
    
    // MARK: - Helper Methods
    
    private func extractKitName(from message: String) -> String? {
        adapter.loadAvailableKits()
        let kitNames = adapter.availableKits.map { $0.name.lowercased() }
        
        for kitName in kitNames {
            if message.lowercased().contains(kitName.lowercased()) {
                return adapter.availableKits.first { $0.name.lowercased() == kitName }?.name
            }
        }
        
        return nil
    }
    
    private func extractProjectName(from message: String) -> String? {
        let patterns = [
            "called ([a-z][a-z0-9]*)",
            "named ([a-z][a-z0-9]*)",
            "project ([a-z][a-z0-9]*)"
        ]
        
        for pattern in patterns {
            if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
               let match = regex.firstMatch(in: message, range: NSRange(message.startIndex..., in: message)),
               let range = Range(match.range(at: 1), in: message) {
                return String(message[range])
            }
        }
        
        return nil
    }
    
    var helpText: String {
        """
        FlowKit Chat Commands:
        
        🎯 KITS:
        • "show me all kits"
        • "list AI kits"
        • "import ChatKit"
        • "create a project called MyApp using AIKit"
        
        ⚙️ SERVICES:
        • "show me AI services"
        • "list workflow services"
        
        🎨 VIEWS:
        • "show me chat views"
        • "list dashboard views"
        
        📐 HIG:
        • "show me HIG components"
        • "what is HIG?"
        
        🤖 AGENTS:
        • "explain what AgentKit does"
        • "setup AI agents"
        
        Just ask naturally!
        """
    }
}
