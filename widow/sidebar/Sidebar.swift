import SwiftUI

/// Primary sidebar for window management
struct Sidebar: View {
    @State private var windows: [WindowInfo] = [
        WindowInfo(id: UUID(), name: "Main Window"),
        WindowInfo(id: UUID(), name: "Inspector"),
        WindowInfo(id: UUID(), name: "Debug Console")
    ]
    @State private var selectedWindow: WindowInfo?
    
    var body: some View {
        List(windows, selection: $selectedWindow) { window in
            HStack {
                Image(systemName: "rectangle")
                Text(window.name)
            }
        }
        .navigationTitle("Windows")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: addWindow) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    private func addWindow() {
        let newWindow = WindowInfo(id: UUID(), name: "New Window \(windows.count + 1)")
        windows.append(newWindow)
    }
}

struct WindowInfo: Identifiable, Hashable {
    let id: UUID
    var name: String
}

#Preview {
    NavigationStack {
        Sidebar()
    }
}
