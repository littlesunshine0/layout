import SwiftUI

/// Menu component for window style mask
struct WindowStyleMaskMenu: View {
    @Binding var styleMask: WindowStyleMask
    
    var body: some View {
        Menu {
            Button("Default") { styleMask = .default }
            Button("Borderless") { styleMask = .borderless }
            Button("Titled") { styleMask = .titled }
            Button("Closable") { styleMask = .closable }
            Button("Resizable") { styleMask = .resizable }
            Button("Utility Window") { styleMask = .utilityWindow }
        } label: {
            Text("Style Mask")
        }
        .padding()
    }
}

#Preview {
    WindowStyleMaskMenu(styleMask: .constant(.default))
}
