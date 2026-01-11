import SwiftUI

/// Menu component for window style
struct WindowStyleMenu: View {
    @Binding var style: WindowStyle
    
    var body: some View {
        Menu {
            Button("Default") { style = .default }
            Button("Plain (Borderless)") { style = .plain }
            Button("Title Bar Only") { style = .titleBarOnly }
            Button("Hidden Title Bar") { style = .hiddenTitleBar }
        } label: {
            Text("Window Style")
        }
        .padding()
    }
}

#Preview {
    WindowStyleMenu(style: .constant(.default))
}
