import Foundation

/// Main adapter for integrating FlowKit project into the layout system
class FlowKitAdapter: @unchecked Sendable {
    static let shared = FlowKitAdapter()
    
    private let crud = CRUDManager.shared
    private let packageMapper = KitPackageMapper.shared
    
    // FlowKit-specific paths (adjust to your actual project path)
    let flowKitRoot = URL(fileURLWithPath: "/Users/tempadmin/Desktop/Project")
    let packageDirectory: URL
    let projectDirectory: URL
    let higDirectory: URL
    
    var availableKits: [FlowKitInfo] = []
    var activeServices: [ServiceInfo] = []
    
    private init() {
        self.packageDirectory = flowKitRoot.appendingPathComponent("package")
        self.projectDirectory = flowKitRoot.appendingPathComponent("Project")
        self.higDirectory = flowKitRoot.appendingPathComponent("HIG")
        
        loadAvailableKits()
    }
    
    // MARK: - Kit Management
    
    func loadAvailableKits() {
        let kitNames = [
            "ActivityKit", "AgentKit", "AIKit", "AnalyticsKit",
            "AppIdeaKit", "AssetKit", "BridgeKit", "ChatKit",
            "CollaborationKit", "CommandKit", "ContentHub", "CoreKit",
            "DataKit", "DesignKit", "DocKit", "ErrorKit",
            "ExportKit", "FeedbackKit", "FileKit", "IconKit",
            "IdeaKit", "IndexerKit", "KnowledgeKit", "LearnKit",
            "MarketplaceKit", "NavigationKit", "NetworkKit", "NLUKit",
            "NotificationKit", "ParseKit", "SearchKit", "SyntaxKit",
            "SystemKit", "UIKit", "UserKit", "WebKit", "WorkflowKit"
        ]
        
        availableKits = kitNames.map { kitName in
            FlowKitInfo(
                name: kitName,
                path: packageDirectory.appendingPathComponent(kitName).path,
                type: determineKitType(kitName),
                hasPackageSwift: true
            )
        }
    }
    
    func importKitAsPackage(_ kitName: String) throws {
        let kitPath = packageDirectory.appendingPathComponent(kitName)
        
        // Read Package.swift to extract info
        let packageSwiftPath = kitPath.appendingPathComponent("Package.swift")
        guard let packageContent = try? String(contentsOf: packageSwiftPath) else {
            throw FlowKitError.kitNotFound(kitName)
        }
        
        // Convert Kit to our package format
        let packageProperties = packageMapper.extractKitProperties(
            kitName: kitName,
            packageContent: packageContent,
            kitPath: kitPath
        )
        
        // Create package in our system
        try crud.createPackage(name: kitName, properties: packageProperties)
        
        print("✓ Imported \(kitName) as package")
    }
    
    func createProjectFromKit(_ kitName: String, projectName: String) throws {
        // First ensure kit is imported as package
        if !(try crud.listPackages().contains(kitName)) {
            try importKitAsPackage(kitName)
        }
        
        // Create project using kit as template
        try crud.createProject(name: projectName, template: kitName)
        
        // Copy kit-specific files
        try copyKitResources(from: kitName, to: projectName)
        
        print("✓ Created project '\(projectName)' from \(kitName)")
    }
    
    // MARK: - Service Management
    
    func loadAvailableServices() {
        let servicesPath = flowKitRoot
            .appendingPathComponent("_archive/v2_full_backup/Services")
        
        guard let serviceFiles = try? FileManager.default.contentsOfDirectory(
            at: servicesPath,
            includingPropertiesForKeys: nil
        ) else { return }
        
        activeServices = serviceFiles
            .filter { $0.pathExtension == "swift" }
            .map { fileURL in
                ServiceInfo(
                    name: fileURL.deletingPathExtension().lastPathComponent,
                    path: fileURL.path,
                    category: categorizeService(fileURL.lastPathComponent)
                )
            }
    }
    
    func executeService(_ serviceName: String, with parameters: [String: Any]) throws -> String {
        // Bridge to your existing service execution
        // This would call into your actual service implementations
        return "Service \(serviceName) executed"
    }
    
    // MARK: - HIG Integration
    
    func loadHIGComponents() -> [HIGComponent] {
        let higComponentsPath = higDirectory.appendingPathComponent("Generated")
        
        return [
            HIGComponent(name: "HIGButtons", type: .button),
            HIGComponent(name: "HIGTextfields", type: .input),
            HIGComponent(name: "HIGLists", type: .list),
            HIGComponent(name: "HIGFeedback", type: .feedback)
        ]
    }
    
    // MARK: - View Integration
    
    func loadAvailableViews() -> [ViewInfo] {
        let viewsPath = flowKitRoot
            .appendingPathComponent("_archive/v2_full_backup/Views")
        
        guard let viewFiles = try? FileManager.default.contentsOfDirectory(
            at: viewsPath,
            includingPropertiesForKeys: nil
        ) else { return [] }
        
        return viewFiles
            .filter { $0.pathExtension == "swift" }
            .map { fileURL in
                ViewInfo(
                    name: fileURL.deletingPathExtension().lastPathComponent,
                    path: fileURL.path,
                    category: categorizeView(fileURL.lastPathComponent)
                )
            }
    }
    
    // MARK: - Workspace Integration
    
    func createFlowKitWorkspace() throws {
        // Create main FlowKit workspace in our system
        let workspacePath = "/workspaces/layout/Projects/FlowKit"
        
        try FileManager.default.createDirectory(
            atPath: workspacePath,
            withIntermediateDirectories: true
        )
        
        // Link to your actual project
        let symlinkPath = workspacePath + "/source"
        try? FileManager.default.removeItem(atPath: symlinkPath)
        try FileManager.default.createSymbolicLink(
            atPath: symlinkPath,
            withDestinationPath: flowKitRoot.path
        )
        
        print("✓ FlowKit workspace created with symlink to source")
    }
    
    // MARK: - Helper Methods
    
    private func determineKitType(_ kitName: String) -> KitType {
        if kitName.hasSuffix("Kit") {
            let base = kitName.replacingOccurrences(of: "Kit", with: "")
            switch base {
            case "AI", "Agent", "NLU": return .intelligence
            case "Chat", "Command", "Workflow": return .interaction
            case "Data", "File", "Network": return .infrastructure
            case "UI", "Design", "Navigation": return .presentation
            default: return .utility
            }
        }
        return .other
    }
    
    private func categorizeService(_ serviceName: String) -> ServiceCategory {
        let name = serviceName.lowercased()
        if name.contains("ai") || name.contains("ml") { return .ai }
        if name.contains("workflow") { return .workflow }
        if name.contains("command") || name.contains("executor") { return .execution }
        if name.contains("database") || name.contains("file") { return .storage }
        if name.contains("analytics") { return .analytics }
        return .other
    }
    
    private func categorizeView(_ viewName: String) -> ViewCategory {
        let name = viewName.lowercased()
        if name.contains("chat") { return .chat }
        if name.contains("dashboard") { return .dashboard }
        if name.contains("workflow") { return .workflow }
        if name.contains("documentation") { return .documentation }
        return .other
    }
    
    private func copyKitResources(from kitName: String, to projectName: String) throws {
        // Copy kit-specific resources to project
        let kitSourcePath = packageDirectory
            .appendingPathComponent(kitName)
            .appendingPathComponent("Sources/\(kitName)")
        
        let projectPath = URL(fileURLWithPath: "/workspaces/layout/Projects/\(projectName)")
        
        // Copy models, views, etc.
        // This is a simplified version - adjust based on your needs
        print("Copying resources from \(kitName) to \(projectName)")
    }
}

// MARK: - Data Models

struct FlowKitInfo: Identifiable {
    let id = UUID()
    let name: String
    let path: String
    let type: KitType
    let hasPackageSwift: Bool
}

enum KitType: String, Codable {
    case intelligence = "Intelligence"
    case interaction = "Interaction"
    case infrastructure = "Infrastructure"
    case presentation = "Presentation"
    case utility = "Utility"
    case other = "Other"
}

struct ServiceInfo: Identifiable {
    let id = UUID()
    let name: String
    let path: String
    let category: ServiceCategory
}

enum ServiceCategory: String {
    case ai = "AI/ML"
    case workflow = "Workflow"
    case execution = "Execution"
    case storage = "Storage"
    case analytics = "Analytics"
    case other = "Other"
}

struct ViewInfo: Identifiable {
    let id = UUID()
    let name: String
    let path: String
    let category: ViewCategory
}

enum ViewCategory: String {
    case chat = "Chat"
    case dashboard = "Dashboard"
    case workflow = "Workflow"
    case documentation = "Documentation"
    case other = "Other"
}

struct HIGComponent: Identifiable {
    let id = UUID()
    let name: String
    let type: HIGComponentType
}

enum HIGComponentType {
    case button
    case input
    case list
    case feedback
}

enum FlowKitError: LocalizedError {
    case kitNotFound(String)
    case invalidPackage(String)
    case integrationFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .kitNotFound(let name): return "Kit not found: \(name)"
        case .invalidPackage(let msg): return "Invalid package: \(msg)"
        case .integrationFailed(let msg): return "Integration failed: \(msg)"
        }
    }
}
