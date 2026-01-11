import SwiftUI

/// Number field component for window level
struct WindowLevelNumberField: View {
    @Binding var level: Int
    
    var body: some View {
        HStack {
            Text("Window Level:")
                .font(.body)
            TextField("Level", value: $level, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 100)
        }
        .padding()
    }
}

#Preview {
    WindowLevelNumberField(level: .constant(0))
}
