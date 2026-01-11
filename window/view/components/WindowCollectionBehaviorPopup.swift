import SwiftUI

/// Popup button component for window collection behavior
struct WindowCollectionBehaviorPopup: View {
    @Binding var behavior: WindowCollectionBehavior
    
    var body: some View {
        HStack {
            Text("Collection Behavior:")
                .font(.body)
            Spacer()
            Menu {
                Button("Default") { behavior = .default }
                Button("Can Join All Spaces") { behavior = .canJoinAllSpaces }
                Button("Move to Active Space") { behavior = .moveToActiveSpace }
                Button("Managed") { behavior = .managed }
                Button("Transient") { behavior = .transient }
            } label: {
                Text("Select")
                    .font(.body)
            }
        }
        .padding()
    }
}

#Preview {
    WindowCollectionBehaviorPopup(behavior: .constant(.default))
}
