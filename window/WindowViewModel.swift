import Foundation
import Combine

/// ViewModel for individual window management
class WindowViewModel: ObservableObject {
    @Published var model: WindowModel
    
    init(model: WindowModel) {
        self.model = model
    }
    
    func updateTitle(_ title: String) {
        model.title = title
    }
    
    func updateFrame(_ frame: CGRect) {
        model.frame = frame
    }
}
