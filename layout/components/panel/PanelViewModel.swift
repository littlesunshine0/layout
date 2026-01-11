import Foundation
import Combine

// MARK: - Panel ViewModel

class PanelViewModel: ObservableObject {
    @Published var model: PanelModel
    @Published var draggingPanel: PanelModel.ActivePanel?
    
    // Future integration point
    private var dataSource: PanelDataSource?
    
    init(model: PanelModel = .mock(), dataSource: PanelDataSource? = nil) {
        self.model = model
        self.dataSource = dataSource
    }
    
    // Open panel
    func openPanel(type: PanelModel.PanelType) {
        guard model.activePanels.count < model.maxCount else {
            print("Maximum panels reached")
            return
        }
        
        // Calculate cascade position
        let offset: CGFloat = 30 * CGFloat(model.activePanels.count)
        let position = CGPoint(x: 100 + offset, y: 100 + offset)
        
        let newPanel = PanelModel.ActivePanel(type: type, position: position)
        model.activePanels.append(newPanel)
        print("Opened panel: \(type.title)")
    }
    
    // Close panel
    func closePanel(_ panel: PanelModel.ActivePanel) {
        model.activePanels.removeAll { $0.id == panel.id }
        print("Closed panel: \(panel.type.title)")
    }
    
    // Toggle minimize
    func toggleMinimize(_ panel: PanelModel.ActivePanel) {
        if let index = model.activePanels.firstIndex(where: { $0.id == panel.id }) {
            model.activePanels[index].isMinimized.toggle()
        }
    }
    
    // Update panel position (drag)
    func updatePanelPosition(_ panel: PanelModel.ActivePanel, to position: CGPoint) {
        if let index = model.activePanels.firstIndex(where: { $0.id == panel.id }) {
            model.activePanels[index].position = position
        }
    }
    
    // Update panel size (resize)
    func updatePanelSize(_ panel: PanelModel.ActivePanel, to size: CGSize) {
        if let index = model.activePanels.firstIndex(where: { $0.id == panel.id }) {
            let constrainedSize = CGSize(
                width: max(size.width, model.minWidth),
                height: max(size.height, model.minHeight)
            )
            model.activePanels[index].size = constrainedSize
        }
    }
    
    // Bring to front
    func bringToFront(_ panel: PanelModel.ActivePanel) {
        if let index = model.activePanels.firstIndex(where: { $0.id == panel.id }) {
            let panel = model.activePanels.remove(at: index)
            model.activePanels.append(panel)
        }
    }
    
    // Future integration point
    func connectToRealData(_ dataSource: PanelDataSource) {
        self.dataSource = dataSource
        // Subscribe to panel state updates
    }
}

// MARK: - Data Source Protocol

protocol PanelDataSource {
    var panelsPublisher: AnyPublisher<[PanelModel.ActivePanel], Never> { get }
    func savePanelState(_ panels: [PanelModel.ActivePanel])
    func loadPanelState() -> [PanelModel.ActivePanel]
}
