import SwiftUI

/// Popup button component for window style mask
struct WindowStyleMaskPopup: View {
    @Binding var styleMask: WindowStyleMask
    
    var body: some View {
        HStack {
            Text("Style Mask:")
                .font(.body)
            Spacer()
            Menu {
                Button("Default") { styleMask = .default }
                Button("Borderless") { styleMask = .borderless }
                Button("Titled") { styleMask = .titled }
                Button("Closable") { styleMask = .closable }
            } label: {
                Text("Select")
                    .font(.body)
            }
        }
        .padding()
    }
}

#Preview {
    WindowStyleMaskPopup(styleMask: .constant(.default))
}
