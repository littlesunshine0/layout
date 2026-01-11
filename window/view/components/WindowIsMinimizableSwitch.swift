import SwiftUI

/// Switch component for window minimizable property
struct WindowIsMinimizableSwitch: View {
    @Binding var isMinimizable: Bool
    
    var body: some View {
        HStack {
            Text("Minimizable:")
                .font(.body)
            Spacer()
            Toggle("", isOn: $isMinimizable)
                .labelsHidden()
        }
        .padding()
    }
}

#Preview {
    WindowIsMinimizableSwitch(isMinimizable: .constant(true))
}
