import SwiftUI

/// Popup button component for toolbar style
struct ToolbarStylePopup: View {
    @Binding var style: ToolbarStyle
    
    var body: some View {
        HStack {
            Text("Toolbar Style:")
                .font(.body)
            Spacer()
            Menu {
                Button("Automatic") { style = .automatic }
                Button("Expanded") { style = .expanded }
                Button("Preference") { style = .preference }
                Button("Unified") { style = .unified }
                Button("Unified Compact") { style = .unifiedCompact }
            } label: {
                Text("Select")
                    .font(.body)
            }
        }
        .padding()
    }
}

#Preview {
    ToolbarStylePopup(style: .constant(.automatic))
}
