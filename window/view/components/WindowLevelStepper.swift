import SwiftUI

/// Stepper component for window level
struct WindowLevelStepper: View {
    @Binding var level: Int
    
    var body: some View {
        HStack {
            Text("Window Level:")
                .font(.body)
            Spacer()
            Stepper(value: $level, in: -10...100) {
                Text("\(level)")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

#Preview {
    WindowLevelStepper(level: .constant(0))
}
