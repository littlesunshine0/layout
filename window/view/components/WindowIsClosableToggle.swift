import SwiftUI

/// Toggle component for window closable property
struct WindowIsClosableToggle: View {
    @Binding var isClosable: Bool
    
    var body: some View {
        Toggle("Closable", isOn: $isClosable)
            .padding()
    }
}

#Preview {
    WindowIsClosableToggle(isClosable: .constant(true))
}
