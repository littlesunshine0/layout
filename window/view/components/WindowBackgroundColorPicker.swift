import SwiftUI

/// Color picker component for window background color
struct WindowBackgroundColorPicker: View {
    @Binding var color: Color
    
    var body: some View {
        HStack {
            Text("Background Color:")
                .font(.body)
            Spacer()
            ColorPicker("", selection: $color)
                .labelsHidden()
        }
        .padding()
    }
}

#Preview {
    WindowBackgroundColorPicker(color: .constant(.white))
}
