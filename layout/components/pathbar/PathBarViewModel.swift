import Foundation
import Combine

// MARK: - PathBar DataSource Protocol

@available(macOS 10.15, iOS 13.0, *)
protocol PathBarDataSource {
    func createSegment(_ segment: PathBarModel.PathSegment)
    func updateSegment(_ segment: PathBarModel.PathSegment)
    func deleteSegment(_ segment: PathBarModel.PathSegment)
    func fetchSegments() -> [PathBarModel.PathSegment]
}

// MARK: - PathBar ViewModel

@available(macOS 10.15, iOS 13.0, *)
final class PathBarViewModel: ObservableObject {
    // Published Properties
    @Published var model: PathBarModel
    @Published var segments: [PathBarModel.PathSegment]
    @Published var currentPath: String = ""
    @Published var selectedSegment: PathBarModel.PathSegment?
    
    // Private
    private var dataSource: PathBarDataSource?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init(model: PathBarModel = .mock(), segments: [PathBarModel.PathSegment] = []) {
        self.model = model
        self.segments = segments.sorted { $0.order < $1.order }
        self.currentPath = segments.last?.path ?? ""
    }
    
    // MARK: - CRUD Operations
    
    func createSegment(name: String, path: String, icon: String? = nil) {
        let newOrder = segments.count
        let segment = PathBarModel.PathSegment(
            name: name,
            path: path,
            icon: icon,
            order: newOrder
        )
        
        if let dataSource = dataSource {
            dataSource.createSegment(segment)
        } else {
            segments.append(segment)
        }
        
        currentPath = path
    }
    
    func getSegment(byId id: String) -> PathBarModel.PathSegment? {
        segments.first { $0.id == id }
    }
    
    func updateSegment(_ segment: PathBarModel.PathSegment) {
        if let index = segments.firstIndex(where: { $0.id == segment.id }) {
            if let dataSource = dataSource {
                dataSource.updateSegment(segment)
            }
            
            segments[index] = segment
        }
    }
    
    func deleteSegment(_ segment: PathBarModel.PathSegment) {
        if let dataSource = dataSource {
            dataSource.deleteSegment(segment)
        }
        
        segments.removeAll { $0.id == segment.id }
        reorderSegments()
    }
    
    // MARK: - Navigation
    
    func navigateToPath(_ path: String) {
        setPathFromString(path)
        currentPath = path
    }
    
    func navigateToSegment(_ segment: PathBarModel.PathSegment) {
        if let index = segments.firstIndex(where: { $0.id == segment.id }) {
            segments = Array(segments[0...index])
            currentPath = segment.path
            selectedSegment = segment
        }
    }
    
    func navigateUp() {
        guard segments.count > 1 else { return }
        segments.removeLast()
        currentPath = segments.last?.path ?? ""
        selectedSegment = segments.last
    }
    
    func navigateToHome() {
        guard model.showsHome, let home = segments.first else { return }
        segments = [home]
        currentPath = home.path
        selectedSegment = home
    }
    
    func navigateToRoot() {
        let root = PathBarModel.PathSegment(name: "/", path: "/", icon: "internaldrive", order: 0)
        segments = [root]
        currentPath = "/"
        selectedSegment = root
    }
    
    // MARK: - Path Parsing
    
    func setPathFromString(_ pathString: String) {
        var components = pathString.components(separatedBy: "/").filter { !$0.isEmpty }
        var newSegments: [PathBarModel.PathSegment] = []
        
        // Add root or home
        if pathString.hasPrefix("/") {
            newSegments.append(PathBarModel.PathSegment(
                name: "/",
                path: "/",
                icon: "internaldrive",
                order: 0
            ))
        } else if pathString.hasPrefix("~") {
            components.removeFirst()
            newSegments.append(PathBarModel.PathSegment(
                name: "~",
                path: NSHomeDirectory(),
                icon: "house.fill",
                order: 0
            ))
        }
        
        // Add components
        var currentPath = pathString.hasPrefix("/") ? "" : NSHomeDirectory()
        for (index, component) in components.enumerated() {
            currentPath += "/\(component)"
            let icon = iconForPath(currentPath)
            newSegments.append(PathBarModel.PathSegment(
                name: component,
                path: currentPath,
                icon: icon,
                order: newSegments.count
            ))
        }
        
        segments = newSegments
        truncateSegmentsIfNeeded()
    }
    
    func pathString() -> String {
        guard !segments.isEmpty else { return "" }
        
        if segments.first?.name == "~" {
            let components = segments.dropFirst().map { $0.name }
            return "~/" + components.joined(separator: "/")
        } else if segments.first?.name == "/" {
            let components = segments.dropFirst().map { $0.name }
            return "/" + components.joined(separator: "/")
        }
        
        return segments.map { $0.name }.joined(separator: "/")
    }
    
    // MARK: - Truncation
    
    func truncateSegmentsIfNeeded() {
        guard segments.count > model.maxSegments else { return }
        
        switch model.truncationMode {
        case .head:
            let keep = segments.suffix(model.maxSegments)
            segments = Array(keep)
        case .middle:
            let headCount = model.maxSegments / 2
            let tailCount = model.maxSegments - headCount
            let head = segments.prefix(headCount)
            let tail = segments.suffix(tailCount)
            segments = Array(head) + Array(tail)
        case .tail:
            let keep = segments.prefix(model.maxSegments)
            segments = Array(keep)
        }
        
        reorderSegments()
    }
    
    // MARK: - Helper Methods
    
    private func reorderSegments() {
        for (index, _) in segments.enumerated() {
            segments[index].order = index
        }
    }
    
    private func iconForPath(_ path: String) -> String {
        let lastComponent = (path as NSString).lastPathComponent
        
        if path.hasSuffix(".pdf") { return "doc.richtext" }
        if path.hasSuffix(".txt") { return "doc.text" }
        if path.hasSuffix(".swift") { return "swift" }
        if path.hasSuffix(".jpg") || path.hasSuffix(".png") { return "photo" }
        
        switch lastComponent {
        case "Applications": return "app.fill"
        case "Documents": return "doc.fill"
        case "Desktop": return "macwindow"
        case "Downloads": return "arrow.down.circle.fill"
        case "Pictures": return "photo.fill"
        case "Music": return "music.note"
        case "Movies": return "film.fill"
        default: return "folder.fill"
        }
    }
    
    // MARK: - Data Source
    
    func setDataSource(_ dataSource: PathBarDataSource) {
        self.dataSource = dataSource
        loadSegments()
    }
    
    func loadSegments() {
        guard let dataSource = dataSource else { return }
        segments = dataSource.fetchSegments().sorted { $0.order < $1.order }
        currentPath = segments.last?.path ?? ""
    }
}
