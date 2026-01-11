import SwiftUI

/// Text field component for editing window title
struct WindowTitleTextField: View {
    @Binding var title: String
    
    var body: some View {
        HStack {
            Text("Title:")
                .font(.body)
            TextField("Window Title", text: $title)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

#Preview {
    WindowTitleTextField(title: .constant("My Window"))
}
