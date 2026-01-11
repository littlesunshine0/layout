import SwiftUI

/// Toggle component for window minimizable property
struct WindowIsMinimizableToggle: View {
    @Binding var isMinimizable: Bool
    
    var body: some View {
        Toggle("Minimizable", isOn: $isMinimizable)
            .padding()
    }
}

#Preview {
    WindowIsMinimizableToggle(isMinimizable: .constant(true))
}
