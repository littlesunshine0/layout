import SwiftUI

/// Switch component for window closable property
struct WindowIsClosableSwitch: View {
    @Binding var isClosable: Bool
    
    var body: some View {
        HStack {
            Text("Closable:")
                .font(.body)
            Spacer()
            Toggle("", isOn: $isClosable)
                .labelsHidden()
        }
        .padding()
    }
}

#Preview {
    WindowIsClosableSwitch(isClosable: .constant(true))
}
