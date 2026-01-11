import SwiftUI

/// A view that displays all window properties in a list format
struct WindowPropertyListView: View {
    @State private var windowTitle = WindowTitle()
    @State private var isVisible = WindowIsVisible()
    @State private var frame = WindowFrame()
    @State private var isResizable = WindowIsResizable()
    @State private var isMinimizable = WindowIsMinimizable()
    @State private var isClosable = WindowIsClosable()
    @State private var isFullScreen = WindowIsFullScreen()
    @State private var alphaValue = WindowAlphaValue()
    @State private var backgroundColor = WindowBackgroundColor()
    @State private var collectionBehavior = WindowCollectionBehavior.default
    @State private var styleMask = WindowStyleMask.default
    @State private var level = WindowLevel.normal
    @State private var aspectRatio = WindowAspectRatio.widescreen
    @State private var hasToolbar = WindowHasToolbar()
    @State private var toolbarStyle = ToolbarStyle.default
    @State private var windowStyle = WindowStyle.default
    @State private var hidesOnDeactivate = WindowHidesOnDeactivate()
    @State private var restorationBehavior = WindowRestorationBehavior.default
    @State private var contentAspectRatio = WindowContentAspectRatio.widescreen
    
    var body: some View {
        List {
            Section(header: Text("Basic Properties")) {
                PropertyRow(name: "Title", value: windowTitle.value)
                PropertyRow(name: "Is Visible", value: String(isVisible.value))
                PropertyRow(name: "Alpha Value", value: String(format: "%.2f", alphaValue.value))
            }
            
            Section(header: Text("Frame & Size")) {
                PropertyRow(name: "X", value: String(format: "%.0f", frame.x))
                PropertyRow(name: "Y", value: String(format: "%.0f", frame.y))
                PropertyRow(name: "Width", value: String(format: "%.0f", frame.width))
                PropertyRow(name: "Height", value: String(format: "%.0f", frame.height))
            }
            
            Section(header: Text("Behavior")) {
                PropertyRow(name: "Is Resizable", value: String(isResizable.value))
                PropertyRow(name: "Is Minimizable", value: String(isMinimizable.value))
                PropertyRow(name: "Is Closable", value: String(isClosable.value))
                PropertyRow(name: "Is Full Screen", value: String(isFullScreen.value))
                PropertyRow(name: "Hides on Deactivate", value: String(hidesOnDeactivate.value))
            }
            
            Section(header: Text("Appearance")) {
                PropertyRow(name: "Window Style", value: windowStyle.description)
                PropertyRow(name: "Has Toolbar", value: String(hasToolbar.value))
                PropertyRow(name: "Toolbar Style", value: String(describing: toolbarStyle))
                PropertyRow(name: "Window Level", value: String(level.value))
            }
            
            Section(header: Text("Aspect Ratios")) {
                PropertyRow(name: "Window Aspect Ratio", value: String(format: "%.2f:%.2f", aspectRatio.width, aspectRatio.height))
                PropertyRow(name: "Content Aspect Ratio", value: String(format: "%.2f:%.2f", contentAspectRatio.width, contentAspectRatio.height))
            }
            
            Section(header: Text("Advanced")) {
                PropertyRow(name: "Collection Behavior", value: String(describing: collectionBehavior))
                PropertyRow(name: "Style Mask", value: String(describing: styleMask))
                PropertyRow(name: "Restoration Behavior", value: restorationBehavior.description)
            }
        }
        .navigationTitle("Window Properties")
    }
}

struct PropertyRow: View {
    let name: String
    let value: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.body)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        WindowPropertyListView()
    }
}
