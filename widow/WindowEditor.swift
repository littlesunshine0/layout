import SwiftUI

/// Main window editor combining all property editors
struct WindowEditor: View {
    @StateObject private var viewModel = WindowViewModels()
    @State private var selectedSection: EditorSection = .basic
    
    enum EditorSection: String, CaseIterable {
        case basic = "Basic"
        case frame = "Frame & Size"
        case behavior = "Behavior"
        case appearance = "Appearance"
        case advanced = "Advanced"
    }
    
    var body: some View {
        NavigationSplitView {
            // Sidebar
            List(EditorSection.allCases, id: \.self, selection: $selectedSection) { section in
                Label(section.rawValue, systemImage: iconForSection(section))
            }
            .navigationTitle("Window Editor")
        } detail: {
            // Main content
            ScrollView {
                VStack(spacing: 0) {
                    switch selectedSection {
                    case .basic:
                        basicPropertiesView
                    case .frame:
                        framePropertiesView
                    case .behavior:
                        behaviorPropertiesView
                    case .appearance:
                        appearancePropertiesView
                    case .advanced:
                        advancedPropertiesView
                    }
                }
            }
        }
    }
    
    private var basicPropertiesView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Basic Properties")
                .font(.title)
                .padding()
            
            WindowTitleTextField(title: $viewModel.windowTitle.value)
            WindowIsVisibleToggle(isVisible: $viewModel.isVisible.value)
            WindowAlphaValueSlider(alpha: Binding(
                get: { Double(viewModel.alphaValue.value) },
                set: { viewModel.alphaValue.value = CGFloat($0) }
            ))
            
            Divider()
        }
    }
    
    private var framePropertiesView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Frame & Size")
                .font(.title)
                .padding()
            
            WindowFrameEditor(frame: $viewModel.frame)
            WindowAspectRatioNumberField(
                width: $viewModel.aspectRatio.width,
                height: $viewModel.aspectRatio.height
            )
            
            Divider()
        }
    }
    
    private var behaviorPropertiesView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Behavior")
                .font(.title)
                .padding()
            
            WindowIsResizableToggle(isResizable: $viewModel.isResizable.value)
            WindowIsMinimizableToggle(isMinimizable: $viewModel.isMinimizable.value)
            WindowIsClosableToggle(isClosable: $viewModel.isClosable.value)
            WindowHidesOnDeactivateToggle(hidesOnDeactivate: $viewModel.hidesOnDeactivate.value)
            
            Divider()
        }
    }
    
    private var appearancePropertiesView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Appearance")
                .font(.title)
                .padding()
            
            WindowStylePopup(style: $viewModel.windowStyle)
            WindowBackgroundColorPicker(color: .constant(.white))
            WindowHasToolbarToggle(hasToolbar: $viewModel.hasToolbar.value)
            
            if viewModel.hasToolbar.value {
                ToolbarStylePopup(style: $viewModel.toolbarStyle)
            }
            
            WindowLevelStepper(level: $viewModel.level.value)
            
            Divider()
        }
    }
    
    private var advancedPropertiesView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Advanced")
                .font(.title)
                .padding()
            
            WindowCollectionBehaviorPopup(behavior: $viewModel.collectionBehavior)
            WindowStyleMaskPopup(styleMask: $viewModel.styleMask)
            
            Divider()
        }
    }
    
    private func iconForSection(_ section: EditorSection) -> String {
        switch section {
        case .basic: return "info.circle"
        case .frame: return "rectangle.resize.vertical"
        case .behavior: return "gearshape"
        case .appearance: return "paintbrush"
        case .advanced: return "slider.horizontal.3"
        }
    }
}

#Preview {
    WindowEditor()
}
