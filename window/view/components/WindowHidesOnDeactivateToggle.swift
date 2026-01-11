import SwiftUI

/// Toggle component for window hides on deactivate property
struct WindowHidesOnDeactivateToggle: View {
    @Binding var hidesOnDeactivate: Bool
    
    var body: some View {
        Toggle("Hides on Deactivate", isOn: $hidesOnDeactivate)
            .padding()
    }
}

#Preview {
    WindowHidesOnDeactivateToggle(hidesOnDeactivate: .constant(false))
}
