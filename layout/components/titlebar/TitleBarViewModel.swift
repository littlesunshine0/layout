import Foundation
import Combine

// MARK: - TitleBar ViewModel

class TitleBarViewModel: ObservableObject {
    @Published var model: TitleBarModel
    @Published var projectTitle: String
    @Published var projectIcon: String
    
    // Future integration point for real data
    private var dataSource: TitleBarDataSource?
    
    init(model: TitleBarModel = .mock(), dataSource: TitleBarDataSource? = nil) {
        self.model = model
        self.projectTitle = "FlowKit Project"
        self.projectIcon = "cube.box.fill"
        self.dataSource = dataSource
        
        // TODO: Subscribe to data source when real data is available
    }
    
    // Button actions
    func handleButtonTap(_ button: TitleBarModel.TitleBarButton) {
        switch button {
        case .close:
            print("Close tapped")
        case .minimize:
            print("Minimize tapped")
        case .maximize:
            print("Maximize tapped")
        case .settings:
            print("Settings tapped")
        }
    }
    
    // Future integration point
    func connectToRealData(_ dataSource: TitleBarDataSource) {
        self.dataSource = dataSource
        // Subscribe to updates
    }
}

// MARK: - Data Source Protocol (for future integration)

protocol TitleBarDataSource {
    var titlePublisher: AnyPublisher<String, Never> { get }
    var iconPublisher: AnyPublisher<String, Never> { get }
}
