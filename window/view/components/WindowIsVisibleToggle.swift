import SwiftUI

/// Toggle component for window visibility
struct WindowIsVisibleToggle: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        Toggle("Window Visible", isOn: $isVisible)
            .padding()
    }
}

#Preview {
    WindowIsVisibleToggle(isVisible: .constant(true))
}
