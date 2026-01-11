import SwiftUI

/// Main application integrating all CRUD interfaces
@main
struct LayoutApp: App {
    var body: some Scene {
        WindowGroup {
            MainAppView()
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("New Project...") {
                    // Trigger new project
                }
                .keyboardShortcut("n", modifiers: [.command])
                
                Button("New Package...") {
                    // Trigger new package
                }
                .keyboardShortcut("n", modifiers: [.command, .shift])
            }
        }
    }
}

struct MainAppView: View {
    @State private var selectedView: MainView = .flowkit
    
    enum MainView: String, CaseIterable {
        case flowkit = "FlowKit Integration"
        case crud = "CRUD Manager"
        case livePreview = "Live Preview"
        case editor = "Window Editor"
        case library = "Library Browser"
    }
    
    var body: some View {
        NavigationSplitView {
            List(MainView.allCases, id: \.self, selection: $selectedView) { view in
                Label(view.rawValue, systemImage: iconForView(view))
            }
            .navigationTitle("Layout Manager")
        } detail: {
            Group {
                switch selectedView {
                case .flowkit:
                    FlowKitDashboardView()
                case .crud:
                    CRUDInterfaceView()
                case .livePreview:
                    LivePreviewWindow(projectPath: "/workspaces/layout/Projects/MyNewApp/layout/widow")
                case .editor:
                    WindowEditor()
                case .library:
                    LibraryBrowser()
                }
            }
        }
        .frame(minWidth: 1000, minHeight: 700)
    }
    
    private func iconForView(_ view: MainView) -> String {
        switch view {
        case .flowkit: return "cube.box.fill"
        case .crud: return "square.grid.2x2"
        case .livePreview: return "play.rectangle"
        case .editor: return "slider.horizontal.3"
        case .library: return "books.vertical"
        }
    }
}

#Preview {
    MainAppView()
}
