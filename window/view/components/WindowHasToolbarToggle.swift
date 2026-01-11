import SwiftUI

/// Toggle component for window toolbar property
struct WindowHasToolbarToggle: View {
    @Binding var hasToolbar: Bool
    
    var body: some View {
        Toggle("Has Toolbar", isOn: $hasToolbar)
            .padding()
    }
}

#Preview {
    WindowHasToolbarToggle(hasToolbar: .constant(false))
}
