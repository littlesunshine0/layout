import SwiftUI

/// Popup button component for window style
struct WindowStylePopup: View {
    @Binding var style: WindowStyle
    
    var body: some View {
        HStack {
            Text("Window Style:")
                .font(.body)
            Spacer()
            Menu {
                Button("Default") { style = .default }
                Button("Plain") { style = .plain }
                Button("Title Bar Only") { style = .titleBarOnly }
                Button("Hidden Title Bar") { style = .hiddenTitleBar }
            } label: {
                Text(style.description)
                    .font(.body)
            }
        }
        .padding()
    }
}

#Preview {
    WindowStylePopup(style: .constant(.default))
}
