import SwiftUI

/// Unified CRUD UI interface with all operations accessible visually
struct CRUDInterfaceView: View {
    @StateObject private var crud = CRUDManager.shared
    @State private var selectedTab: CRUDTab = .projects
    @State private var projects: [String] = []
    @State private var packages: [String] = []
    @State private var selectedProject: String?
    @State private var selectedPackage: String?
    
    @State private var showCreateProject = false
    @State private var showCreatePackage = false
    @State private var newItemName = ""
    @State private var selectedTemplate = "None"
    
    enum CRUDTab: String, CaseIterable {
        case projects = "Projects"
        case packages = "Packages"
        case files = "Swift Files"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Tab selector
            Picker("View", selection: $selectedTab) {
                ForEach(CRUDTab.allCases, id: \.self) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Divider()
            
            // Content area
            Group {
                switch selectedTab {
                case .projects:
                    projectsView
                case .packages:
                    packagesView
                case .files:
                    swiftFilesView
                }
            }
            
            Divider()
            
            // Operation log
            operationLogView
        }
        .onAppear {
            refreshData()
        }
    }
    
    // MARK: - Projects View
    private var projectsView: some View {
        VStack {
            HStack {
                Text("Projects")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { showCreateProject = true }) {
                    Label("New Project", systemImage: "plus.circle.fill")
                }
            }
            .padding()
            
            if projects.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "folder.badge.plus")
                        .font(.system(size: 60))
                        .foregroundColor(.secondary)
                    Text("No projects yet")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Button("Create Your First Project") {
                        showCreateProject = true
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(projects, id: \.self, selection: $selectedProject) { project in
                    HStack {
                        Image(systemName: "folder.fill")
                            .foregroundColor(.blue)
                        Text(project)
                        Spacer()
                        
                        Button(action: {
                            showProjectDetails(project)
                        }) {
                            Image(systemName: "info.circle")
                        }
                        .buttonStyle(.plain)
                        
                        Button(action: {
                            deleteProject(project)
                        }) {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(.plain)
                        .foregroundColor(.red)
                    }
                }
            }
        }
        .sheet(isPresented: $showCreateProject) {
            createProjectSheet
        }
    }
    
    // MARK: - Packages View
    private var packagesView: some View {
        VStack {
            HStack {
                Text("Packages")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: { showCreatePackage = true }) {
                    Label("New Package", systemImage: "plus.circle.fill")
                }
            }
            .padding()
            
            List(packages, id: \.self, selection: $selectedPackage) { package in
                HStack {
                    Image(systemName: "shippingbox.fill")
                        .foregroundColor(.orange)
                    Text(package)
                    Spacer()
                    
                    Button(action: {
                        showPackageDetails(package)
                    }) {
                        Image(systemName: "info.circle")
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        deletePackage(package)
                    }) {
                        Image(systemName: "trash")
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.red)
                }
            }
        }
        .sheet(isPresented: $showCreatePackage) {
            createPackageSheet
        }
    }
    
    // MARK: - Swift Files View
    private var swiftFilesView: some View {
        VStack {
            HStack {
                Text("Swift Files")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    // Create Swift file
                }) {
                    Label("New File", systemImage: "plus.circle.fill")
                }
            }
            .padding()
            
            Text("Select a project to manage Swift files")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    // MARK: - Operation Log
    private var operationLogView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Operations")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            ScrollView(.horizontal) {
                Text(crud.lastOperation)
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
        .padding(8)
        .background(Color.black.opacity(0.9))
    }
    
    // MARK: - Create Project Sheet
    private var createProjectSheet: some View {
        VStack(spacing: 20) {
            Text("Create New Project")
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("Project Name", text: $newItemName)
                .textFieldStyle(.roundedBorder)
            
            Picker("Template", selection: $selectedTemplate) {
                Text("None").tag("None")
                Text("Inspector Window").tag("InspectorWindow")
                Text("HUD Window").tag("HUDWindow")
                Text("Document Window").tag("DocumentWindow")
            }
            .pickerStyle(.menu)
            
            HStack {
                Button("Cancel") {
                    showCreateProject = false
                    newItemName = ""
                }
                .buttonStyle(.bordered)
                
                Button("Create") {
                    createProject()
                }
                .buttonStyle(.borderedProminent)
                .disabled(newItemName.isEmpty)
            }
        }
        .padding(30)
        .frame(width: 400)
    }
    
    // MARK: - Create Package Sheet
    private var createPackageSheet: some View {
        VStack(spacing: 20) {
            Text("Create New Package")
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("Package Name", text: $newItemName)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Button("Cancel") {
                    showCreatePackage = false
                    newItemName = ""
                }
                .buttonStyle(.bordered)
                
                Button("Create") {
                    createPackage()
                }
                .buttonStyle(.borderedProminent)
                .disabled(newItemName.isEmpty)
            }
        }
        .padding(30)
        .frame(width: 400)
    }
    
    // MARK: - Helper Methods
    private func refreshData() {
        projects = (try? crud.listProjects()) ?? []
        packages = (try? crud.listPackages()) ?? []
    }
    
    private func createProject() {
        let template = selectedTemplate == "None" ? nil : selectedTemplate
        try? crud.createProject(name: newItemName, template: template)
        showCreateProject = false
        newItemName = ""
        selectedTemplate = "None"
        refreshData()
    }
    
    private func createPackage() {
        try? crud.createPackage(name: newItemName, properties: [:])
        showCreatePackage = false
        newItemName = ""
        refreshData()
    }
    
    private func deleteProject(_ name: String) {
        try? crud.deleteProject(name: name)
        refreshData()
    }
    
    private func deletePackage(_ name: String) {
        try? crud.deletePackage(name: name)
        refreshData()
    }
    
    private func showProjectDetails(_ name: String) {
        if let info = try? crud.readProject(name: name) {
            print("Project: \(info.name)")
            print("Properties: \(info.properties)")
        }
    }
    
    private func showPackageDetails(_ name: String) {
        if let content = try? crud.readPackage(name: name) {
            print("Package: \(name)")
            print(content)
        }
    }
}

#Preview {
    CRUDInterfaceView()
        .frame(width: 800, height: 600)
}
