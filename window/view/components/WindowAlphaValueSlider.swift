import SwiftUI

/// Slider component for window alpha value (transparency)
struct WindowAlphaValueSlider: View {
    @Binding var alpha: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Opacity:")
                    .font(.body)
                Spacer()
                Text(String(format: "%.2f", alpha))
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            Slider(value: $alpha, in: 0.0...1.0, step: 0.01)
        }
        .padding()
    }
}

#Preview {
    WindowAlphaValueSlider(alpha: .constant(1.0))
}
