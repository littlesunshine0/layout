import SwiftUI

/// Live editor for window frame with direct manipulation
struct WindowFrameEditor: View {
    @Binding var frame: WindowFrame
    @State private var isDragging = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Window Frame Editor")
                .font(.title)
                .padding()
            
            // Visual representation
            GeometryReader { geometry in
                ZStack {
                    // Canvas
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .border(Color.gray, width: 1)
                    
                    // Window representation
                    Rectangle()
                        .fill(Color.blue.opacity(0.3))
                        .border(Color.blue, width: 2)
                        .frame(
                            width: frame.width / 2,
                            height: frame.height / 2
                        )
                        .position(
                            x: CGFloat(frame.x / 2) + (frame.width / 4),
                            y: CGFloat(frame.y / 2) + (frame.height / 4)
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    isDragging = true
                                    frame.x = value.location.x * 2
                                    frame.y = value.location.y * 2
                                }
                                .onEnded { _ in
                                    isDragging = false
                                }
                        )
                }
            }
            .frame(height: 400)
            .padding()
            
            // Numerical controls
            VStack(spacing: 12) {
                HStack {
                    Text("X:")
                        .frame(width: 60, alignment: .trailing)
                    TextField("X", value: $frame.x, format: .number)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Y:")
                        .frame(width: 60, alignment: .trailing)
                    TextField("Y", value: $frame.y, format: .number)
                        .textFieldStyle(.roundedBorder)
                }
                
                HStack {
                    Text("Width:")
                        .frame(width: 60, alignment: .trailing)
                    TextField("Width", value: $frame.width, format: .number)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Height:")
                        .frame(width: 60, alignment: .trailing)
                    TextField("Height", value: $frame.height, format: .number)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .padding()
        }
    }
}

#Preview {
    WindowFrameEditor(frame: .constant(WindowFrame()))
}
