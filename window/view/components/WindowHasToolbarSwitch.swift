import SwiftUI

/// Switch component for window toolbar property
struct WindowHasToolbarSwitch: View {
    @Binding var hasToolbar: Bool
    
    var body: some View {
        HStack {
            Text("Has Toolbar:")
                .font(.body)
            Spacer()
            Toggle("", isOn: $hasToolbar)
                .labelsHidden()
        }
        .padding()
    }
}

#Preview {
    WindowHasToolbarSwitch(hasToolbar: .constant(false))
}
