import SwiftUI

/// Switch component for window visibility
struct WindowIsVisibleSwitch: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        HStack {
            Text("Visible:")
                .font(.body)
            Spacer()
            Toggle("", isOn: $isVisible)
                .labelsHidden()
        }
        .padding()
    }
}

#Preview {
    WindowIsVisibleSwitch(isVisible: .constant(true))
}
