import Foundation

/// Unified CRUD manager for Projects, Packages, and Swift files
class CRUDManager: @unchecked Sendable {
    static let shared = CRUDManager()
    
    private let fileManager = FileManager.default
    private let baseURL = URL(fileURLWithPath: "/workspaces/layout")
    
    var lastOperation: String = ""
    var operationLog: [String] = []
    
    // MARK: - Project Operations
    
    /// Create a new project
    func createProject(name: String, template: String? = nil) throws {
        let projectURL = baseURL
            .appendingPathComponent("Projects")
            .appendingPathComponent(name)
        
        // Create directory structure
        try fileManager.createDirectory(at: projectURL, withIntermediateDirectories: true)
        try fileManager.createDirectory(at: projectURL.appendingPathComponent("layout/widow/properties"), withIntermediateDirectories: true)
        try fileManager.createDirectory(at: projectURL.appendingPathComponent("Models"), withIntermediateDirectories: true)
        try fileManager.createDirectory(at: projectURL.appendingPathComponent("ViewModels"), withIntermediateDirectories: true)
        try fileManager.createDirectory(at: projectURL.appendingPathComponent("Views"), withIntermediateDirectories: true)
        
        // If template provided, import it
        if let template = template {
            try PackageManager.shared.importPackage(template, toProject: name)
        } else {
            // Create default properties
            try createDefaultProperties(in: projectURL.appendingPathComponent("layout/widow/properties"))
        }
        
        log("✓ Created project: \(name)")
    }
    
    /// Read project information
    func readProject(name: String) throws -> ProjectInfo {
        let projectURL = baseURL
            .appendingPathComponent("Projects")
            .appendingPathComponent(name)
        
        guard fileManager.fileExists(atPath: projectURL.path) else {
            throw CRUDError.notFound("Project '\(name)' not found")
        }
        
        let properties = try loadProperties(from: projectURL.appendingPathComponent("layout/widow/properties"))
        
        log("✓ Read project: \(name)")
        return ProjectInfo(name: name, path: projectURL.path, properties: properties)
    }
    
    /// Update project properties
    func updateProject(name: String, property: String, value: String) throws {
        let propertyURL = baseURL
            .appendingPathComponent("Projects")
            .appendingPathComponent(name)
            .appendingPathComponent("layout/widow/properties")
            .appendingPathComponent(property)
        
        try value.write(to: propertyURL, atomically: true, encoding: .utf8)
        log("✓ Updated \(name)/\(property) = \(value)")
    }
    
    /// Delete a project
    func deleteProject(name: String) throws {
        let projectURL = baseURL
            .appendingPathComponent("Projects")
            .appendingPathComponent(name)
        
        try fileManager.removeItem(at: projectURL)
        log("✓ Deleted project: \(name)")
    }
    
    /// List all projects
    func listProjects() throws -> [String] {
        let projectsURL = baseURL.appendingPathComponent("Projects")
        let contents = try fileManager.contentsOfDirectory(at: projectsURL, includingPropertiesForKeys: nil)
        return contents.filter { $0.hasDirectoryPath }.map { $0.lastPathComponent }
    }
    
    // MARK: - Package Operations
    
    /// Create a new package template
    func createPackage(name: String, properties: [String: String]) throws {
        let packageURL = baseURL
            .appendingPathComponent("Packages")
            .appendingPathComponent("\(name).pkg")
        
        var content = """
        # Window Package: \(name)
        
        [Metadata]
        PackageName=\(name)
        Version=1.0.0
        Author=User
        Description=Custom window package
        
        [Properties]
        
        """
        
        for (key, value) in properties {
            content += "\(key)=\(value)\n"
        }
        
        try content.write(to: packageURL, atomically: true, encoding: .utf8)
        log("✓ Created package: \(name)")
    }
    
    /// Read package information
    func readPackage(name: String) throws -> String {
        let packageURL = baseURL
            .appendingPathComponent("Packages")
            .appendingPathComponent("\(name).pkg")
        
        let content = try String(contentsOf: packageURL, encoding: .utf8)
        log("✓ Read package: \(name)")
        return content
    }
    
    /// Update package
    func updatePackage(name: String, property: String, value: String) throws {
        let packageURL = baseURL
            .appendingPathComponent("Packages")
            .appendingPathComponent("\(name).pkg")
        
        var content = try String(contentsOf: packageURL, encoding: .utf8)
        
        // Update the property line
        let lines = content.components(separatedBy: .newlines)
        var newLines: [String] = []
        var found = false
        
        for line in lines {
            if line.starts(with: "\(property)=") {
                newLines.append("\(property)=\(value)")
                found = true
            } else {
                newLines.append(line)
            }
        }
        
        if !found {
            // Add new property
            if let propsIndex = newLines.firstIndex(where: { $0 == "[Properties]" }) {
                newLines.insert("\(property)=\(value)", at: propsIndex + 1)
            }
        }
        
        content = newLines.joined(separator: "\n")
        try content.write(to: packageURL, atomically: true, encoding: .utf8)
        log("✓ Updated package: \(name)")
    }
    
    /// Delete a package
    func deletePackage(name: String) throws {
        let packageURL = baseURL
            .appendingPathComponent("Packages")
            .appendingPathComponent("\(name).pkg")
        
        try fileManager.removeItem(at: packageURL)
        log("✓ Deleted package: \(name)")
    }
    
    /// List all packages
    func listPackages() throws -> [String] {
        let packagesURL = baseURL.appendingPathComponent("Packages")
        let contents = try fileManager.contentsOfDirectory(at: packagesURL, includingPropertiesForKeys: nil)
        return contents
            .filter { $0.pathExtension == "pkg" }
            .map { $0.deletingPathExtension().lastPathComponent }
    }
    
    // MARK: - Swift File Operations
    
    /// Create a new Swift file
    func createSwiftFile(project: String, path: String, name: String, content: String) throws {
        let fileURL = baseURL
            .appendingPathComponent("Projects")
            .appendingPathComponent(project)
            .appendingPathComponent(path)
            .appendingPathComponent("\(name).swift")
        
        // Create directory if needed
        try fileManager.createDirectory(
            at: fileURL.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )
        
        try content.write(to: fileURL, atomically: true, encoding: .utf8)
        log("✓ Created Swift file: \(project)/\(path)/\(name).swift")
    }
    
    /// Read Swift file
    func readSwiftFile(project: String, path: String, name: String) throws -> String {
        let fileURL = baseURL
            .appendingPathComponent("Projects")
            .appendingPathComponent(project)
            .appendingPathComponent(path)
            .appendingPathComponent("\(name).swift")
        
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        log("✓ Read Swift file: \(project)/\(path)/\(name).swift")
        return content
    }
    
    /// Update Swift file
    func updateSwiftFile(project: String, path: String, name: String, content: String) throws {
        let fileURL = baseURL
            .appendingPathComponent("Projects")
            .appendingPathComponent(project)
            .appendingPathComponent(path)
            .appendingPathComponent("\(name).swift")
        
        try content.write(to: fileURL, atomically: true, encoding: .utf8)
        log("✓ Updated Swift file: \(project)/\(path)/\(name).swift")
    }
    
    /// Delete Swift file
    func deleteSwiftFile(project: String, path: String, name: String) throws {
        let fileURL = baseURL
            .appendingPathComponent("Projects")
            .appendingPathComponent(project)
            .appendingPathComponent(path)
            .appendingPathComponent("\(name).swift")
        
        try fileManager.removeItem(at: fileURL)
        log("✓ Deleted Swift file: \(project)/\(path)/\(name).swift")
    }
    
    // MARK: - Helper Methods
    
    private func createDefaultProperties(in directory: URL) throws {
        let defaults: [String: String] = [
            "WindowTitle": "Untitled",
            "WindowIsVisible": "true",
            "WindowFrame": "x:0,y:0,width:800,height:600",
            "WindowIsResizable": "true",
            "WindowIsMinimizable": "true",
            "WindowIsClosable": "true",
            "WindowAlphaValue": "1.0"
        ]
        
        for (key, value) in defaults {
            let fileURL = directory.appendingPathComponent(key)
            try value.write(to: fileURL, atomically: true, encoding: .utf8)
        }
    }
    
    private func loadProperties(from directory: URL) throws -> [String: String] {
        let contents = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
        var properties: [String: String] = [:]
        
        for fileURL in contents where !fileURL.hasDirectoryPath {
            let key = fileURL.lastPathComponent
            if let value = try? String(contentsOf: fileURL, encoding: .utf8) {
                properties[key] = value.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        return properties
    }
    
    private func log(_ message: String) {
        lastOperation = message
        operationLog.append("\(Date()): \(message)")
        print(message)
    }
}

// MARK: - Data Models

struct ProjectInfo {
    let name: String
    let path: String
    let properties: [String: String]
}

enum CRUDError: LocalizedError {
    case notFound(String)
    case invalidOperation(String)
    case fileSystemError(String)
    
    var errorDescription: String? {
        switch self {
        case .notFound(let msg): return "Not Found: \(msg)"
        case .invalidOperation(let msg): return "Invalid Operation: \(msg)"
        case .fileSystemError(let msg): return "File System Error: \(msg)"
        }
    }
}
