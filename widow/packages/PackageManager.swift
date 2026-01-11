import SwiftUI

/// Package manager for importing and managing window templates
class PackageManager: ObservableObject {
    static let shared = PackageManager()
    
    let packagesDirectory = URL(fileURLWithPath: "/workspaces/layout/Packages")
    let projectsDirectory = URL(fileURLWithPath: "/workspaces/layout/Projects")
    
    @Published var availablePackages: [String] = []
    
    init() {
        loadPackages()
    }
    
    func loadPackages() {
        do {
            let contents = try FileManager.default.contentsOfDirectory(
                at: packagesDirectory,
                includingPropertiesForKeys: nil
            )
            availablePackages = contents
                .filter { $0.pathExtension == "pkg" }
                .map { $0.deletingPathExtension().lastPathComponent }
        } catch {
            print("Error loading packages: \(error)")
        }
    }
    
    func importPackage(_ packageName: String, toProject projectName: String) throws {
        let packageURL = packagesDirectory.appendingPathComponent("\(packageName).pkg")
        let projectPropertiesURL = projectsDirectory
            .appendingPathComponent(projectName)
            .appendingPathComponent("layout/widow/properties")
        
        // Create project directory if needed
        try FileManager.default.createDirectory(
            at: projectPropertiesURL,
            withIntermediateDirectories: true
        )
        
        // Read package file
        let packageContent = try String(contentsOf: packageURL, encoding: .utf8)
        
        // Parse and create property files
        parseAndCreateProperties(packageContent, in: projectPropertiesURL)
    }
    
    private func parseAndCreateProperties(_ content: String, in directory: URL) {
        let lines = content.components(separatedBy: .newlines)
        var inPropertiesSection = false
        
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            
            if trimmed == "[Properties]" {
                inPropertiesSection = true
                continue
            }
            
            if trimmed.hasPrefix("[") {
                inPropertiesSection = false
                continue
            }
            
            if inPropertiesSection && !trimmed.isEmpty && !trimmed.hasPrefix("#") {
                let parts = trimmed.components(separatedBy: "=")
                if parts.count == 2 {
                    let propertyName = parts[0].trimmingCharacters(in: .whitespaces)
                    let propertyValue = parts[1].trimmingCharacters(in: .whitespaces)
                    
                    let propertyFile = directory.appendingPathComponent(propertyName)
                    try? propertyValue.write(to: propertyFile, atomically: true, encoding: .utf8)
                }
            }
        }
    }
    
    func createSymbolicLink(from source: String, to destination: String, property: String) throws {
        let sourceURL = projectsDirectory
            .appendingPathComponent(source)
            .appendingPathComponent("layout/widow/properties")
            .appendingPathComponent(property)
        
        let destURL = projectsDirectory
            .appendingPathComponent(destination)
            .appendingPathComponent("layout/widow/properties")
            .appendingPathComponent(property)
        
        // Create symbolic link
        try FileManager.default.createSymbolicLink(
            at: destURL,
            withDestinationURL: sourceURL
        )
    }
}
