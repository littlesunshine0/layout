import SwiftUI

/// Switch component for window resizable property
struct WindowIsResizableSwitch: View {
    @Binding var isResizable: Bool
    
    var body: some View {
        HStack {
            Text("Resizable:")
                .font(.body)
            Spacer()
            Toggle("", isOn: $isResizable)
                .labelsHidden()
        }
        .padding()
    }
}

#Preview {
    WindowIsResizableSwitch(isResizable: .constant(true))
}
