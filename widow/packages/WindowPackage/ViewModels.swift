import Foundation
import Combine

/// ViewModels for managing window property state and business logic
class WindowViewModels: ObservableObject {
    @Published var windowTitle: WindowTitle
    @Published var isVisible: WindowIsVisible
    @Published var frame: WindowFrame
    @Published var isResizable: WindowIsResizable
    @Published var isMinimizable: WindowIsMinimizable
    @Published var isClosable: WindowIsClosable
    @Published var isFullScreen: WindowIsFullScreen
    @Published var alphaValue: WindowAlphaValue
    @Published var backgroundColor: WindowBackgroundColor
    @Published var collectionBehavior: WindowCollectionBehavior
    @Published var styleMask: WindowStyleMask
    @Published var level: WindowLevel
    @Published var aspectRatio: WindowAspectRatio
    @Published var hasToolbar: WindowHasToolbar
    @Published var toolbarStyle: ToolbarStyle
    @Published var windowStyle: WindowStyle
    @Published var hidesOnDeactivate: WindowHidesOnDeactivate
    @Published var restorationBehavior: WindowRestorationBehavior
    @Published var contentAspectRatio: WindowContentAspectRatio
    
    init() {
        self.windowTitle = WindowTitle()
        self.isVisible = WindowIsVisible()
        self.frame = WindowFrame()
        self.isResizable = WindowIsResizable()
        self.isMinimizable = WindowIsMinimizable()
        self.isClosable = WindowIsClosable()
        self.isFullScreen = WindowIsFullScreen()
        self.alphaValue = WindowAlphaValue()
        self.backgroundColor = WindowBackgroundColor()
        self.collectionBehavior = .default
        self.styleMask = .default
        self.level = .normal
        self.aspectRatio = .widescreen
        self.hasToolbar = WindowHasToolbar()
        self.toolbarStyle = .default
        self.windowStyle = .default
        self.hidesOnDeactivate = WindowHidesOnDeactivate()
        self.restorationBehavior = .default
        self.contentAspectRatio = .widescreen
    }
}
