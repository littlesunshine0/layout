import SwiftUI

/// Menu component for toolbar style
struct ToolbarStyleMenu: View {
    @Binding var style: ToolbarStyle
    
    var body: some View {
        Menu {
            Button("Automatic") { style = .automatic }
            Button("Expanded") { style = .expanded }
            Button("Preference") { style = .preference }
            Button("Unified") { style = .unified }
            Button("Unified Compact") { style = .unifiedCompact }
        } label: {
            Text("Toolbar Style")
        }
        .padding()
    }
}

#Preview {
    ToolbarStyleMenu(style: .constant(.automatic))
}
