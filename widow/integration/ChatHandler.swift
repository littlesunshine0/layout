import Foundation

/// Chat interface handler for natural language CRUD operations
class ChatHandler {
    private let crud = CRUDManager.shared
    private lazy var flowKitHandler = FlowKitChatHandler()
    
    func process(_ message: String) -> String {
        // Check if it's FlowKit-related first
        if message.lowercased().contains("kit") ||
           message.lowercased().contains("service") ||
           message.lowercased().contains("agent") ||
           message.lowercased().contains("workflow") ||
           message.lowercased().contains("hig") {
            return flowKitHandler.process(message)
        }
        
        return processStandard(message)
    }
    
    private func processStandard(_ message: String) -> String {
        let lowercased = message.lowercased()
        
        // Project creation
        if lowercased.contains("create") && lowercased.contains("project") {
            return handleCreateProject(message: lowercased)
        }
        
        // Project listing
        if (lowercased.contains("list") || lowercased.contains("show")) && lowercased.contains("project") {
            return handleListProjects()
        }
        
        // Package operations
        if lowercased.contains("package") {
            return handlePackageOperation(message: lowercased)
        }
        
        // Property updates
        if lowercased.contains("set") || lowercased.contains("change") || lowercased.contains("update") {
            return handlePropertyUpdate(message: lowercased)
        }
        
        // Window property queries
        if lowercased.contains("what") && (lowercased.contains("title") || lowercased.contains("size") || lowercased.contains("opacity")) {
            return handlePropertyQuery(message: lowercased)
        }
        
        // Make transparent/opaque
        if lowercased.contains("transparent") || lowercased.contains("opac") {
            return handleTransparency(message: lowercased)
        }
        
        // Resize operations
        if lowercased.contains("resize") || lowercased.contains("size") {
            return handleResize(message: lowercased)
        }
        
        // Help
        if lowercased.contains("help") || lowercased.contains("what can you do") {
            return helpText
        }
        
        return "I can help you with:\n• Creating/managing projects\n• Managing packages\n• Updating window properties\n• Creating Swift files\n\nTry: 'create a new project called MyApp' or 'make the window transparent'"
    }
    
    private func handleCreateProject(message: String) -> String {
        // Extract project name
        let patterns = [
            "create.*project.*called ([a-z0-9]+)",
            "create.*project ([a-z0-9]+)",
            "new project ([a-z0-9]+)"
        ]
        
        for pattern in patterns {
            if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
               let match = regex.firstMatch(in: message, range: NSRange(message.startIndex..., in: message)),
               let range = Range(match.range(at: 1), in: message) {
                let name = String(message[range])
                
                do {
                    // Check if template is mentioned
                    var template: String? = nil
                    if message.contains("inspector") {
                        template = "InspectorWindow"
                    } else if message.contains("hud") {
                        template = "HUDWindow"
                    } else if message.contains("document") {
                        template = "DocumentWindow"
                    }
                    
                    try crud.createProject(name: name, template: template)
                    var response = "✓ Created project '\(name)'"
                    if let template = template {
                        response += " using \(template) template"
                    }
                    return response
                } catch {
                    return "Error creating project: \(error.localizedDescription)"
                }
            }
        }
        
        return "I couldn't extract the project name. Try: 'create a project called MyApp'"
    }
    
    private func handleListProjects() -> String {
        do {
            let projects = try crud.listProjects()
            if projects.isEmpty {
                return "You don't have any projects yet. Create one with: 'create a project called MyApp'"
            }
            return "Your projects:\n" + projects.map { "• \($0)" }.joined(separator: "\n")
        } catch {
            return "Error listing projects: \(error.localizedDescription)"
        }
    }
    
    private func handlePackageOperation(message: String) -> String {
        if message.contains("list") || message.contains("show") {
            do {
                let packages = try crud.listPackages()
                return "Available packages:\n" + packages.map { "• \($0)" }.joined(separator: "\n")
            } catch {
                return "Error: \(error.localizedDescription)"
            }
        }
        
        return "I can list packages for you. Try: 'show me the packages'"
    }
    
    private func handlePropertyUpdate(message: String) -> String {
        // Window title
        if message.contains("title") {
            if let regex = try? NSRegularExpression(pattern: "title.*to (['\"]?)([^'\"]+)\\1", options: .caseInsensitive),
               let match = regex.firstMatch(in: message, range: NSRange(message.startIndex..., in: message)),
               let range = Range(match.range(at: 2), in: message) {
                let title = String(message[range])
                do {
                    try crud.updateProject(name: "MyNewApp", property: "WindowTitle", value: title)
                    return "✓ Window title changed to '\(title)'"
                } catch {
                    return "Error: \(error.localizedDescription)"
                }
            }
        }
        
        return "What would you like to update? Try: 'set the title to My Window'"
    }
    
    private func handlePropertyQuery(message: String) -> String {
        do {
            let info = try crud.readProject(name: "MyNewApp")
            
            if message.contains("title") {
                return "The window title is: '\(info.properties["WindowTitle"] ?? "Unknown")'"
            }
            
            if message.contains("size") {
                return "The window size is: \(info.properties["WindowFrame"] ?? "Unknown")"
            }
            
            if message.contains("opacity") || message.contains("transparent") {
                return "The window opacity is: \(info.properties["WindowAlphaValue"] ?? "Unknown")"
            }
            
            return "Current properties:\n" + info.properties.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
    
    private func handleTransparency(message: String) -> String {
        var alpha = 0.5
        
        if message.contains("semi") {
            alpha = 0.5
        } else if message.contains("very") || message.contains("highly") {
            alpha = 0.3
        } else if message.contains("slightly") {
            alpha = 0.8
        } else if message.contains("opaque") {
            alpha = 1.0
        }
        
        do {
            try crud.updateProject(name: "MyNewApp", property: "WindowAlphaValue", value: "\(alpha)")
            return "✓ Window opacity set to \(alpha) (\(Int(alpha * 100))%)"
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
    
    private func handleResize(message: String) -> String {
        // Extract dimensions
        if let regex = try? NSRegularExpression(pattern: "(\\d+)\\s*[x×]\\s*(\\d+)", options: .caseInsensitive),
           let match = regex.firstMatch(in: message, range: NSRange(message.startIndex..., in: message)) {
            
            let widthRange = Range(match.range(at: 1), in: message)!
            let heightRange = Range(match.range(at: 2), in: message)!
            
            let width = String(message[widthRange])
            let height = String(message[heightRange])
            
            do {
                try crud.updateProject(name: "MyNewApp", property: "WindowFrame", value: "x:0,y:0,width:\(width),height:\(height)")
                return "✓ Window resized to \(width)×\(height)"
            } catch {
                return "Error: \(error.localizedDescription)"
            }
        }
        
        return "Specify dimensions like: 'resize to 1024x768'"
    }
    
    private var helpText: String {
        """
        I can help you with:
        
        📦 PROJECT MANAGEMENT:
        • "create a project called MyApp"
        • "list my projects"
        • "show project details for MyApp"
        
        📋 PACKAGE MANAGEMENT:
        • "show me the packages"
        • "create a package called CustomWindow"
        
        🪟 WINDOW PROPERTIES:
        • "set the title to My Window"
        • "make the window transparent"
        • "resize to 1024x768"
        • "what is the current title?"
        
        💻 SWIFT FILES:
        • "create a Swift file called MyModel"
        
        Just ask in natural language!
        """
    }
}
