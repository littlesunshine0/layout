import SwiftUI

/// Number field component for window aspect ratio
struct WindowAspectRatioNumberField: View {
    @Binding var width: Double
    @Binding var height: Double
    
    var body: some View {
        HStack {
            Text("Aspect Ratio:")
                .font(.body)
            TextField("Width", value: $width, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 60)
            Text(":")
            TextField("Height", value: $height, format: .number)
                .textFieldStyle(.roundedBorder)
                .frame(width: 60)
        }
        .padding()
    }
}

#Preview {
    WindowAspectRatioNumberField(width: .constant(16), height: .constant(9))
}
