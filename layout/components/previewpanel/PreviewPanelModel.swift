import Foundation
import Combine

// MARK: - PreviewPanel Model

struct PreviewPanelModel {
    // Layout Properties
    var width: Double
    var height: Double
    var contentPadding: Double
    var toolbarHeight: Double
    
    // Visual Properties
    var backgroundColor: String
    var showsToolbar: Bool
    var showsMetadata: Bool
    
    // Zoom Properties
    var showsZoomControls: Bool
    var minZoom: Double
    var maxZoom: Double
    var defaultZoom: Double
    
    // Interaction Properties
    var allowsEditing: Bool
    
    // MARK: - Enums
    
    enum PreviewType: String, CaseIterable {
        case image
        case video
        case audio
        case document
        case code
        case pdf
        case markdown
        
        var description: String {
            switch self {
            case .image: return "Image"
            case .video: return "Video"
            case .audio: return "Audio"
            case .document: return "Document"
            case .code: return "Code"
            case .pdf: return "PDF"
            case .markdown: return "Markdown"
            }
        }
        
        var icon: String {
            switch self {
            case .image: return "photo"
            case .video: return "film"
            case .audio: return "waveform"
            case .document: return "doc.text"
            case .code: return "chevron.left.forwardslash.chevron.right"
            case .pdf: return "doc.richtext"
            case .markdown: return "text.alignleft"
            }
        }
    }
    
    // MARK: - PreviewItem Data
    
    struct PreviewItem: Identifiable {
        let id: String
        var name: String
        var type: PreviewType
        var filePath: String
        var fileSize: Int64
        var dimensions: (width: Int, height: Int)?
        var duration: TimeInterval?
        var metadata: [String: String]
        var thumbnailPath: String?
        var createdAt: Date
        var modifiedAt: Date
        var tags: [String]
        var isFavorite: Bool
        
        init(
            id: String = UUID().uuidString,
            name: String,
            type: PreviewType,
            filePath: String,
            fileSize: Int64 = 0,
            dimensions: (width: Int, height: Int)? = nil,
            duration: TimeInterval? = nil,
            metadata: [String: String] = [:],
            thumbnailPath: String? = nil,
            createdAt: Date = Date(),
            modifiedAt: Date = Date(),
            tags: [String] = [],
            isFavorite: Bool = false
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.filePath = filePath
            self.fileSize = fileSize
            self.dimensions = dimensions
            self.duration = duration
            self.metadata = metadata
            self.thumbnailPath = thumbnailPath
            self.createdAt = createdAt
            self.modifiedAt = modifiedAt
            self.tags = tags
            self.isFavorite = isFavorite
        }
        
        var formattedSize: String {
            ByteCountFormatter.string(fromByteCount: fileSize, countStyle: .file)
        }
    }
    
    // MARK: - Mock Data
    
    static func mock() -> PreviewPanelModel {
        PreviewPanelModel(
            width: 800,
            height: 600,
            contentPadding: 16,
            toolbarHeight: 44,
            backgroundColor: "#FFFFFF",
            showsToolbar: true,
            showsMetadata: true,
            showsZoomControls: true,
            minZoom: 0.1,
            maxZoom: 5.0,
            defaultZoom: 1.0,
            allowsEditing: true
        )
    }
    
    static func mockItems() -> [PreviewItem] {
        [
            PreviewItem(
                name: "sunset.jpg",
                type: .image,
                filePath: "/Users/demo/Pictures/sunset.jpg",
                fileSize: 2_457_600,
                dimensions: (width: 3840, height: 2160),
                metadata: ["Camera": "Canon EOS R5", "ISO": "400"],
                tags: ["nature", "photography"]
            ),
            PreviewItem(
                name: "presentation.pdf",
                type: .pdf,
                filePath: "/Users/demo/Documents/presentation.pdf",
                fileSize: 5_242_880,
                metadata: ["Pages": "24", "Author": "John Doe"],
                tags: ["work", "presentation"]
            ),
            PreviewItem(
                name: "tutorial.mp4",
                type: .video,
                filePath: "/Users/demo/Videos/tutorial.mp4",
                fileSize: 52_428_800,
                duration: 320.5,
                dimensions: (width: 1920, height: 1080),
                metadata: ["Codec": "H.264", "Bitrate": "5000 kbps"],
                tags: ["tutorial", "education"]
            ),
            PreviewItem(
                name: "soundtrack.mp3",
                type: .audio,
                filePath: "/Users/demo/Music/soundtrack.mp3",
                fileSize: 8_388_608,
                duration: 245.2,
                metadata: ["Artist": "John Williams", "Album": "Film Scores"],
                tags: ["music", "soundtrack"],
                isFavorite: true
            ),
            PreviewItem(
                name: "README.md",
                type: .markdown,
                filePath: "/Users/demo/Projects/README.md",
                fileSize: 4096,
                metadata: ["Lines": "156", "Language": "Markdown"],
                tags: ["documentation"]
            ),
            PreviewItem(
                name: "main.swift",
                type: .code,
                filePath: "/Users/demo/Projects/main.swift",
                fileSize: 8192,
                metadata: ["Lines": "234", "Language": "Swift"],
                tags: ["code", "swift"]
            ),
            PreviewItem(
                name: "report.docx",
                type: .document,
                filePath: "/Users/demo/Documents/report.docx",
                fileSize: 1_048_576,
                metadata: ["Pages": "12", "Words": "3450"],
                tags: ["document", "report"]
            )
        ]
    }
    
    // MARK: - Property Loading
    
    static func fromProperties() -> PreviewPanelModel {
        PreviewPanelModel(
            width: PropertyLoader.shared.loadDouble(for: "PreviewPanelWidth") ?? 800,
            height: PropertyLoader.shared.loadDouble(for: "PreviewPanelHeight") ?? 600,
            contentPadding: PropertyLoader.shared.loadDouble(for: "PreviewPanelContentPadding") ?? 16,
            toolbarHeight: PropertyLoader.shared.loadDouble(for: "PreviewPanelToolbarHeight") ?? 44,
            backgroundColor: PropertyLoader.shared.loadString(for: "PreviewPanelBackgroundColor") ?? "#FFFFFF",
            showsToolbar: PropertyLoader.shared.loadBool(for: "PreviewPanelShowsToolbar") ?? true,
            showsMetadata: PropertyLoader.shared.loadBool(for: "PreviewPanelShowsMetadata") ?? true,
            showsZoomControls: PropertyLoader.shared.loadBool(for: "PreviewPanelShowsZoomControls") ?? true,
            minZoom: PropertyLoader.shared.loadDouble(for: "PreviewPanelMinZoom") ?? 0.1,
            maxZoom: PropertyLoader.shared.loadDouble(for: "PreviewPanelMaxZoom") ?? 5.0,
            defaultZoom: PropertyLoader.shared.loadDouble(for: "PreviewPanelDefaultZoom") ?? 1.0,
            allowsEditing: PropertyLoader.shared.loadBool(for: "PreviewPanelAllowsEditing") ?? true
        )
    }
}

// MARK: - PropertyLoader Helper

class PropertyLoader {
    static let shared = PropertyLoader()
    
    private var properties: [String: Any] = [:]
    
    func loadDouble(for key: String) -> Double? {
        properties[key] as? Double
    }
    
    func loadString(for key: String) -> String? {
        properties[key] as? String
    }
    
    func loadBool(for key: String) -> Bool? {
        properties[key] as? Bool
    }
    
    func loadInt(for key: String) -> Int? {
        properties[key] as? Int
    }
}
