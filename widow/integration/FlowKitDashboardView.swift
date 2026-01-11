import SwiftUI

/// FlowKit integration dashboard view
struct FlowKitDashboardView: View {
    @StateObject private var adapter = FlowKitAdapter.shared
    @State private var selectedTab: FlowKitTab = .kits
    @State private var searchText = ""
    
    enum FlowKitTab: String, CaseIterable {
        case kits = "Kits"
        case services = "Services"
        case views = "Views"
        case hig = "HIG"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(systemName: "cube.box.fill")
                    .font(.title)
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading) {
                    Text("FlowKit Integration")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(adapter.availableKits.count) Kits • \(adapter.activeServices.count) Services")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: refresh) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
                .buttonStyle(.bordered)
            }
            .padding()
            
            Divider()
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Search...", text: $searchText)
                    .textFieldStyle(.plain)
            }
            .padding(8)
            .background(Color(nsColor: .controlBackgroundColor))
            .cornerRadius(8)
            .padding(.horizontal)
            
            // Tab selector
            Picker("View", selection: $selectedTab) {
                ForEach(FlowKitTab.allCases, id: \.self) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Divider()
            
            // Content
            ScrollView {
                Group {
                    switch selectedTab {
                    case .kits:
                        kitsView
                    case .services:
                        servicesView
                    case .views:
                        viewsView
                    case .hig:
                        higView
                    }
                }
                .padding()
            }
        }
        .onAppear {
            refresh()
        }
    }
    
    // MARK: - Kits View
    private var kitsView: some View {
        VStack(spacing: 16) {
            let grouped = Dictionary(grouping: filteredKits, by: { $0.type })
            
            ForEach(KitType.allCases.filter { grouped[$0] != nil }, id: \.self) { type in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(type.rawValue)
                            .font(.headline)
                        Spacer()
                        Text("\(grouped[type]?.count ?? 0) kits")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 150), spacing: 12)
                    ], spacing: 12) {
                        ForEach(grouped[type] ?? []) { kit in
                            KitCard(kit: kit)
                        }
                    }
                }
                .padding()
                .background(Color(nsColor: .controlBackgroundColor).opacity(0.5))
                .cornerRadius(12)
            }
        }
    }
    
    // MARK: - Services View
    private var servicesView: some View {
        VStack(spacing: 12) {
            let grouped = Dictionary(grouping: filteredServices, by: { $0.category })
            
            ForEach(ServiceCategory.allCases.filter { grouped[$0] != nil }, id: \.self) { category in
                DisclosureGroup(
                    isExpanded: .constant(true),
                    content: {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(grouped[category] ?? []) { service in
                                ServiceRow(service: service)
                            }
                        }
                    },
                    label: {
                        HStack {
                            Image(systemName: iconForCategory(category))
                            Text(category.rawValue)
                                .font(.headline)
                            Spacer()
                            Text("\(grouped[category]?.count ?? 0)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                )
                .padding()
                .background(Color(nsColor: .controlBackgroundColor).opacity(0.5))
                .cornerRadius(8)
            }
        }
    }
    
    // MARK: - Views View
    private var viewsView: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 200), spacing: 16)
        ], spacing: 16) {
            ForEach(adapter.loadAvailableViews().filter {
                searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
            }) { view in
                ViewCard(view: view)
            }
        }
    }
    
    // MARK: - HIG View
    private var higView: some View {
        VStack(spacing: 16) {
            ForEach(adapter.loadHIGComponents()) { component in
                HIGComponentCard(component: component)
            }
        }
    }
    
    // MARK: - Filtered Data
    private var filteredKits: [FlowKitInfo] {
        adapter.availableKits.filter {
            searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private var filteredServices: [ServiceInfo] {
        adapter.activeServices.filter {
            searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    // MARK: - Helpers
    private func refresh() {
        adapter.loadAvailableKits()
        adapter.loadAvailableServices()
    }
    
    private func iconForCategory(_ category: ServiceCategory) -> String {
        switch category {
        case .ai: return "brain"
        case .workflow: return "arrow.triangle.branch"
        case .execution: return "play.circle"
        case .storage: return "externaldrive"
        case .analytics: return "chart.bar"
        case .other: return "gearshape"
        }
    }
}

// MARK: - Kit Card
struct KitCard: View {
    let kit: FlowKitInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "shippingbox.fill")
                    .foregroundColor(.blue)
                Text(kit.name)
                    .font(.headline)
                    .lineLimit(1)
            }
            
            Text(kit.type.rawValue)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
            
            HStack {
                Button("Import") {
                    importKit(kit.name)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                
                Button("Info") {
                    showKitInfo(kit.name)
                }
                .buttonStyle(.borderless)
                .controlSize(.small)
            }
        }
        .frame(height: 100)
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
        )
    }
    
    private func importKit(_ name: String) {
        try? FlowKitAdapter.shared.importKitAsPackage(name)
    }
    
    private func showKitInfo(_ name: String) {
        let manifest = KitPackageMapper.shared.generateKitManifest(for: name)
        print(manifest.displayInfo)
    }
}

// MARK: - Service Row
struct ServiceRow: View {
    let service: ServiceInfo
    
    var body: some View {
        HStack {
            Image(systemName: "gearshape.fill")
                .foregroundColor(.green)
            Text(service.name)
                .font(.body)
            Spacer()
            Button("Run") {
                runService()
            }
            .buttonStyle(.borderless)
            .controlSize(.small)
        }
        .padding(.vertical, 4)
    }
    
    private func runService() {
        try? FlowKitAdapter.shared.executeService(service.name, with: [:])
    }
}

// MARK: - View Card
struct ViewCard: View {
    let view: ViewInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "rectangle.on.rectangle")
                    .foregroundColor(.orange)
                Text(view.name)
                    .font(.headline)
                    .lineLimit(1)
            }
            
            Text(view.category.rawValue)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(8)
    }
}

// MARK: - HIG Component Card
struct HIGComponentCard: View {
    let component: HIGComponent
    
    var body: some View {
        HStack {
            Image(systemName: "paintbrush.fill")
                .foregroundColor(.purple)
            Text(component.name)
                .font(.headline)
            Spacer()
            Text("HIG")
                .font(.caption)
                .padding(4)
                .background(Color.purple.opacity(0.2))
                .cornerRadius(4)
        }
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(8)
    }
}

// Make KitType CaseIterable
extension KitType: CaseIterable {
    static var allCases: [KitType] {
        [.intelligence, .interaction, .infrastructure, .presentation, .utility, .other]
    }
}

// Make ServiceCategory CaseIterable
extension ServiceCategory: CaseIterable {
    static var allCases: [ServiceCategory] {
        [.ai, .workflow, .execution, .storage, .analytics, .other]
    }
}

#Preview {
    FlowKitDashboardView()
        .frame(width: 900, height: 700)
}
