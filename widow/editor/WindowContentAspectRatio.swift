import SwiftUI

/// Editor for window content aspect ratio
struct WindowContentAspectRatioEditor: View {
    @Binding var aspectRatio: WindowContentAspectRatio
    @State private var selectedPreset: String = "Custom"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Content Aspect Ratio Editor")
                .font(.title)
                .padding()
            
            // Preset selection
            Picker("Preset", selection: $selectedPreset) {
                Text("Custom").tag("Custom")
                Text("Square (1:1)").tag("Square")
                Text("Widescreen (16:9)").tag("Widescreen")
                Text("Standard (4:3)").tag("Standard")
            }
            .pickerStyle(.segmented)
            .padding()
            .onChange(of: selectedPreset) { _, newValue in
                switch newValue {
                case "Square":
                    aspectRatio = .square
                case "Widescreen":
                    aspectRatio = .widescreen
                case "Standard":
                    aspectRatio = .standard
                default:
                    break
                }
            }
            
            // Visual representation
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .aspectRatio(aspectRatio.ratio, contentMode: .fit)
                    .border(Color.blue, width: 2)
                    .frame(maxWidth: 400, maxHeight: 300)
                
                Text("\(String(format: "%.1f", aspectRatio.width)):\(String(format: "%.1f", aspectRatio.height))")
                    .font(.headline)
            }
            .padding()
            
            // Manual controls
            VStack(spacing: 12) {
                HStack {
                    Text("Width:")
                        .frame(width: 80, alignment: .trailing)
                    Slider(value: $aspectRatio.width, in: 1...32, step: 1)
                    Text(String(format: "%.0f", aspectRatio.width))
                        .frame(width: 40)
                }
                
                HStack {
                    Text("Height:")
                        .frame(width: 80, alignment: .trailing)
                    Slider(value: $aspectRatio.height, in: 1...32, step: 1)
                    Text(String(format: "%.0f", aspectRatio.height))
                        .frame(width: 40)
                }
                
                Text("Ratio: \(String(format: "%.3f", aspectRatio.ratio))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .onChange(of: aspectRatio.width) { _, _ in
            selectedPreset = "Custom"
        }
        .onChange(of: aspectRatio.height) { _, _ in
            selectedPreset = "Custom"
        }
    }
}

#Preview {
    WindowContentAspectRatioEditor(aspectRatio: .constant(WindowContentAspectRatio.widescreen))
}
