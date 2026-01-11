import SwiftUI

/// Stepper component for window aspect ratio
struct WindowAspectRatioStepper: View {
    @Binding var width: Double
    @Binding var height: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Aspect Ratio:")
                    .font(.body)
                Spacer()
                Text(String(format: "%.1f:%.1f", width, height))
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            HStack {
                Text("Width:")
                Stepper(value: $width, in: 1...100, step: 1) {
                    Text(String(format: "%.0f", width))
                        .frame(width: 40)
                }
            }
            HStack {
                Text("Height:")
                Stepper(value: $height, in: 1...100, step: 1) {
                    Text(String(format: "%.0f", height))
                        .frame(width: 40)
                }
            }
        }
        .padding()
    }
}

#Preview {
    WindowAspectRatioStepper(width: .constant(16), height: .constant(9))
}
