import Foundation

/// Maps FlowKit SPM packages to our package system
class KitPackageMapper: @unchecked Sendable {
    static let shared = KitPackageMapper()
    
    private init() {}
    
    func extractKitProperties(kitName: String, packageContent: String, kitPath: URL) -> [String: String] {
        var properties: [String: String] = [:]
        
        // Extract basic info from Package.swift
        properties["PackageName"] = kitName
        properties["KitType"] = determineKitType(kitName).rawValue
        
        // Parse Package.swift for dependencies
        let dependencies = extractDependencies(from: packageContent)
        properties["Dependencies"] = dependencies.joined(separator: ",")
        
        // Check for README
        let readmePath = kitPath.appendingPathComponent("README.md")
        if let readme = try? String(contentsOf: readmePath) {
            properties["Description"] = extractDescription(from: readme)
        }
        
        // Scan for major components
        let sourcesPath = kitPath.appendingPathComponent("Sources/\(kitName)")
        if let components = try? FileManager.default.contentsOfDirectory(at: sourcesPath, includingPropertiesForKeys: nil) {
            let swiftFiles = components.filter { $0.pathExtension == "swift" }
            properties["ComponentCount"] = "\(swiftFiles.count)"
            properties["HasModels"] = "\(hasDirectory(at: sourcesPath, named: "Models"))"
            properties["HasViews"] = "\(hasDirectory(at: sourcesPath, named: "Views"))"
            properties["HasServices"] = "\(hasDirectory(at: sourcesPath, named: "Services"))"
        }
        
        // Map to window properties for visualization
        properties["WindowTitle"] = kitName
        properties["WindowIsVisible"] = "true"
        properties["WindowFrame"] = "x:100,y:100,width:800,height:600"
        properties["WindowStyle"] = "default"
        
        // Kit-specific visual properties
        switch determineKitType(kitName) {
        case .intelligence:
            properties["WindowBackgroundColor"] = "r:0.3,g:0.5,b:0.8,a:1.0" // Blue
        case .interaction:
            properties["WindowBackgroundColor"] = "r:0.5,g:0.8,b:0.5,a:1.0" // Green
        case .infrastructure:
            properties["WindowBackgroundColor"] = "r:0.7,g:0.7,b:0.7,a:1.0" // Gray
        case .presentation:
            properties["WindowBackgroundColor"] = "r:0.9,g:0.6,b:0.3,a:1.0" // Orange
        default:
            properties["WindowBackgroundColor"] = "r:1.0,g:1.0,b:1.0,a:1.0" // White
        }
        
        return properties
    }
    
    func createPackageFromKit(_ kitName: String, sourcePath: URL) throws -> String {
        let packageContent = """
        # FlowKit Package: \(kitName)
        # Auto-generated from SPM package
        
        [Metadata]
        PackageName=\(kitName)
        Version=1.0.0
        Author=FlowKit
        Description=Imported from FlowKit SPM package
        SourcePath=\(sourcePath.path)
        KitType=\(determineKitType(kitName).rawValue)
        
        [Properties]
        WindowTitle=\(kitName)
        WindowIsVisible=true
        WindowFrame=x:100,y:100,width:800,height:600
        WindowIsResizable=true
        WindowIsMinimizable=true
        WindowIsClosable=true
        WindowAlphaValue=1.0
        
        [Integration]
        SourcePackage=\(sourcePath.path)
        ImportDate=\(Date())
        """
        
        return packageContent
    }
    
    func generateKitManifest(for kitName: String) -> KitManifest {
        let kitPath = URL(fileURLWithPath: "/path/to/FlowKit/package/\(kitName)")
        
        return KitManifest(
            name: kitName,
            type: determineKitType(kitName),
            sourcePath: kitPath.path,
            hasTests: FileManager.default.fileExists(atPath: kitPath.appendingPathComponent("Tests").path),
            hasREADME: FileManager.default.fileExists(atPath: kitPath.appendingPathComponent("README.md").path),
            targetCount: countTargets(in: kitPath)
        )
    }
    
    // MARK: - Helper Methods
    
    private func extractDependencies(from packageContent: String) -> [String] {
        var deps: [String] = []
        let lines = packageContent.components(separatedBy: .newlines)
        
        for line in lines {
            if line.contains(".package(") {
                // Simple extraction - can be made more robust
                if let urlMatch = line.range(of: "url: \"([^\"]+)\"", options: .regularExpression) {
                    deps.append(String(line[urlMatch]))
                }
            }
        }
        
        return deps
    }
    
    private func extractDescription(from readme: String) -> String {
        let lines = readme.components(separatedBy: .newlines)
        // Get first non-header paragraph
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if !trimmed.isEmpty && !trimmed.hasPrefix("#") && !trimmed.hasPrefix("[![") {
                return trimmed
            }
        }
        return "A FlowKit module"
    }
    
    private func hasDirectory(at path: URL, named: String) -> Bool {
        let dirPath = path.appendingPathComponent(named)
        var isDirectory: ObjCBool = false
        return FileManager.default.fileExists(atPath: dirPath.path, isDirectory: &isDirectory) && isDirectory.boolValue
    }
    
    private func determineKitType(_ kitName: String) -> KitType {
        if kitName.hasSuffix("Kit") {
            let base = kitName.replacingOccurrences(of: "Kit", with: "")
            switch base {
            case "AI", "Agent", "NLU", "Learn", "Knowledge": return .intelligence
            case "Chat", "Command", "Workflow", "Feedback": return .interaction
            case "Data", "File", "Network", "Database", "Storage": return .infrastructure
            case "UI", "Design", "Navigation", "Icon", "Asset": return .presentation
            default: return .utility
            }
        }
        return .other
    }
    
    private func countTargets(in kitPath: URL) -> Int {
        let packageSwiftPath = kitPath.appendingPathComponent("Package.swift")
        guard let content = try? String(contentsOf: packageSwiftPath) else { return 0 }
        
        let targetPattern = "\\.target\\("
        let matches = content.components(separatedBy: targetPattern).count - 1
        return max(0, matches)
    }
}

// MARK: - Kit Manifest

struct KitManifest: Codable {
    let name: String
    let type: KitType
    let sourcePath: String
    let hasTests: Bool
    let hasREADME: Bool
    let targetCount: Int
    
    var displayInfo: String {
        """
        Kit: \(name)
        Type: \(type.rawValue)
        Targets: \(targetCount)
        Tests: \(hasTests ? "✓" : "✗")
        README: \(hasREADME ? "✓" : "✗")
        """
    }
}
