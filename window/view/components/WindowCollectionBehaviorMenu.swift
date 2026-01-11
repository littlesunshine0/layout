import SwiftUI

/// Menu component for window collection behavior
struct WindowCollectionBehaviorMenu: View {
    @Binding var behavior: WindowCollectionBehavior
    
    var body: some View {
        Menu {
            Button("Default") { behavior = .default }
            Button("Can Join All Spaces") { behavior = .canJoinAllSpaces }
            Button("Move to Active Space") { behavior = .moveToActiveSpace }
            Button("Managed") { behavior = .managed }
            Button("Transient") { behavior = .transient }
            Button("Stationary") { behavior = .stationary }
        } label: {
            Text("Collection Behavior")
        }
        .padding()
    }
}

#Preview {
    WindowCollectionBehaviorMenu(behavior: .constant(.default))
}
