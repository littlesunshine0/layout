import Foundation

// MARK: - PreviewPanel Icons

@available(macOS 10.15, iOS 13.0, *)
struct PreviewPanelIcons {
    
    // MARK: - Preview Type Icons
    
    static let imageIcon = "photo"
    static let videoIcon = "film"
    static let audioIcon = "waveform"
    static let documentIcon = "doc.text"
    static let codeIcon = "chevron.left.forwardslash.chevron.right"
    static let pdfIcon = "doc.richtext"
    static let markdownIcon = "text.alignleft"
    
    static func iconForType(_ type: PreviewPanelModel.PreviewType) -> String {
        type.icon
    }
    
    // MARK: - Toolbar Icons
    
    static let zoomInIcon = "plus.magnifyingglass"
    static let zoomOutIcon = "minus.magnifyingglass"
    static let resetZoomIcon = "arrow.up.left.and.arrow.down.right"
    static let fitToWindowIcon = "rectangle.expand.vertical"
    static let actualSizeIcon = "square.resize"
    
    static let editIcon = "pencil"
    static let saveIcon = "square.and.arrow.down"
    static let exportIcon = "square.and.arrow.up"
    static let shareIcon = "square.and.arrow.up"
    static let deleteIcon = "trash"
    
    static let previousIcon = "chevron.left"
    static let nextIcon = "chevron.right"
    static let playIcon = "play.fill"
    static let pauseIcon = "pause.fill"
    static let stopIcon = "stop.fill"
    
    // MARK: - Metadata Icons
    
    static let sizeIcon = "doc.text.magnifyingglass"
    static let dateIcon = "calendar"
    static let dimensionsIcon = "arrow.up.left.and.arrow.down.right"
    static let durationIcon = "clock"
    static let tagIcon = "tag"
    static let favoriteIcon = "star"
    static let favoriteFilledIcon = "star.fill"
    
    // MARK: - Control Icons
    
    static let settingsIcon = "gear"
    static let infoIcon = "info.circle"
    static let gridIcon = "square.grid.2x2"
    static let listIcon = "list.bullet"
    static let searchIcon = "magnifyingglass"
    static let filterIcon = "line.3.horizontal.decrease.circle"
    
    // MARK: - Category Groups
    
    static var toolbarIcons: [String: String] {
        [
            "zoomIn": zoomInIcon,
            "zoomOut": zoomOutIcon,
            "resetZoom": resetZoomIcon,
            "fitToWindow": fitToWindowIcon,
            "actualSize": actualSizeIcon,
            "edit": editIcon,
            "save": saveIcon,
            "export": exportIcon,
            "share": shareIcon,
            "delete": deleteIcon,
            "previous": previousIcon,
            "next": nextIcon,
            "play": playIcon,
            "pause": pauseIcon,
            "stop": stopIcon
        ]
    }
    
    static var metadataIcons: [String: String] {
        [
            "size": sizeIcon,
            "date": dateIcon,
            "dimensions": dimensionsIcon,
            "duration": durationIcon,
            "tag": tagIcon,
            "favorite": favoriteIcon,
            "favoriteFilled": favoriteFilledIcon
        ]
    }
    
    static var controlIcons: [String: String] {
        [
            "settings": settingsIcon,
            "info": infoIcon,
            "grid": gridIcon,
            "list": listIcon,
            "search": searchIcon,
            "filter": filterIcon
        ]
    }
    
    static var typeIcons: [String: String] {
        [
            "image": imageIcon,
            "video": videoIcon,
            "audio": audioIcon,
            "document": documentIcon,
            "code": codeIcon,
            "pdf": pdfIcon,
            "markdown": markdownIcon
        ]
    }
    
    // MARK: - All Icons
    
    static var allIcons: [String: String] {
        var icons: [String: String] = [:]
        icons.merge(toolbarIcons) { (_, new) in new }
        icons.merge(metadataIcons) { (_, new) in new }
        icons.merge(controlIcons) { (_, new) in new }
        icons.merge(typeIcons) { (_, new) in new }
        return icons
    }
    
    // MARK: - Icon Helper Methods
    
    static func getIcon(named name: String) -> String? {
        allIcons[name]
    }
    
    static func iconExists(named name: String) -> Bool {
        allIcons[name] != nil
    }
}
