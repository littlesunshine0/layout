import SwiftUI

/// Library browser for browsing and selecting window packages
struct LibraryBrowser: View {
    @State private var packages: [WindowPackage] = []
    @State private var selectedPackage: WindowPackage?
    @State private var searchText = ""
    
    var filteredPackages: [WindowPackage] {
        if searchText.isEmpty {
            return packages
        }
        return packages.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Search packages...", text: $searchText)
                    .textFieldStyle(.plain)
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(8)
            .background(Color(nsColor: .controlBackgroundColor))
            
            Divider()
            
            // Package grid
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 140), spacing: 16)
                ], spacing: 16) {
                    ForEach(filteredPackages) { package in
                        PackageCard(package: package)
                            .onTapGesture {
                                selectedPackage = package
                            }
                            .onDrag {
                                NSItemProvider(object: package.name as NSString)
                            }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Package Library")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: refreshPackages) {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .onAppear(perform: loadPackages)
    }
    
    private func loadPackages() {
        // Load packages from /Packages/ directory
        packages = [
            WindowPackage(name: "InspectorWindow", icon: "sidebar.right", description: "Utility inspector window"),
            WindowPackage(name: "HUDWindow", icon: "eye", description: "Floating HUD window"),
            WindowPackage(name: "DocumentWindow", icon: "doc", description: "Standard document window")
        ]
    }
    
    private func refreshPackages() {
        loadPackages()
    }
}

struct PackageCard: View {
    let package: WindowPackage
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: package.icon)
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .frame(height: 60)
            
            Text(package.name)
                .font(.headline)
                .lineLimit(1)
            
            Text(package.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
        )
    }
}

struct WindowPackage: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var description: String
}

#Preview {
    NavigationStack {
        LibraryBrowser()
    }
}
