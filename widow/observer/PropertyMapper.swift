import Foundation
import Combine

/// Maps window properties to file system and provides bidirectional sync
class PropertyMapper: ObservableObject {
    private let observer: FileSystemObserver
    private var cancellables = Set<AnyCancellable>()
    
    @Published var windowTitle: String = "Untitled"
    @Published var isVisible: Bool = true
    @Published var frameX: Double = 0
    @Published var frameY: Double = 0
    @Published var frameWidth: Double = 800
    @Published var frameHeight: Double = 600
    @Published var isResizable: Bool = true
    @Published var isMinimizable: Bool = true
    @Published var isClosable: Bool = true
    @Published var isFullScreen: Bool = false
    @Published var alphaValue: Double = 1.0
    
    init(propertiesDirectory: URL) {
        self.observer = FileSystemObserver(directory: propertiesDirectory)
        
        // Setup file system monitoring
        observer.onChange = { [weak self] in
            self?.loadAllProperties()
        }
        
        // Setup property change observers for writing back to files
        setupPropertyObservers()
        
        // Load initial values
        loadAllProperties()
    }
    
    private func setupPropertyObservers() {
        $windowTitle
            .dropFirst()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                self?.observer.writeProperty("WindowTitle", value: value)
            }
            .store(in: &cancellables)
        
        $alphaValue
            .dropFirst()
            .debounce(for: 0.1, scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                self?.observer.writeProperty("WindowAlphaValue", value: "\(value)")
            }
            .store(in: &cancellables)
        
        $frameX
            .combineLatest($frameY, $frameWidth, $frameHeight)
            .dropFirst()
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] (x, y, w, h) in
                self?.observer.writeProperty("WindowFrame", value: "x:\(x),y:\(y),width:\(w),height:\(h)")
            }
            .store(in: &cancellables)
    }
    
    private func loadAllProperties() {
        if let title = observer.readProperty("WindowTitle") {
            windowTitle = title
        }
        
        if let alpha = observer.readProperty("WindowAlphaValue"),
           let alphaDouble = Double(alpha) {
            alphaValue = alphaDouble
        }
        
        if let frame = observer.readProperty("WindowFrame") {
            parseFrame(frame)
        }
        
        if let visible = observer.readProperty("WindowIsVisible") {
            isVisible = visible.lowercased() == "true"
        }
        
        if let resizable = observer.readProperty("WindowIsResizable") {
            isResizable = resizable.lowercased() == "true"
        }
    }
    
    private func parseFrame(_ frame: String) {
        // Parse format: "x:100,y:100,width:800,height:600"
        let components = frame.components(separatedBy: ",")
        for component in components {
            let parts = component.components(separatedBy: ":")
            guard parts.count == 2 else { continue }
            let key = parts[0].trimmingCharacters(in: .whitespaces)
            let valueStr = parts[1].trimmingCharacters(in: .whitespaces)
            guard let value = Double(valueStr) else { continue }
            
            switch key {
            case "x": frameX = value
            case "y": frameY = value
            case "width": frameWidth = value
            case "height": frameHeight = value
            default: break
            }
        }
    }
}
