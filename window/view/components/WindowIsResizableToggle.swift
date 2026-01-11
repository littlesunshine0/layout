import SwiftUI

/// Toggle component for window resizable property
struct WindowIsResizableToggle: View {
    @Binding var isResizable: Bool
    
    var body: some View {
        Toggle("Resizable", isOn: $isResizable)
            .padding()
    }
}

#Preview {
    WindowIsResizableToggle(isResizable: .constant(true))
}
