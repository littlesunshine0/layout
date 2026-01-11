import Foundation

// MARK: - PathBar Icons

@available(macOS 10.15, iOS 13.0, *)
struct PathBarIcons {
    
    // System Icons
    static let homeIcon = "house.fill"
    static let rootIcon = "internaldrive"
    static let folderIcon = "folder.fill"
    
    // Special Folders
    static let applicationsIcon = "app.fill"
    static let documentsIcon = "doc.fill"
    static let desktopIcon = "macwindow"
    static let downloadsIcon = "arrow.down.circle.fill"
    static let picturesIcon = "photo.fill"
    static let musicIcon = "music.note"
    static let moviesIcon = "film.fill"
    static let libraryIcon = "books.vertical.fill"
    
    // File Types
    static let pdfIcon = "doc.richtext"
    static let textIcon = "doc.text"
    static let codeIcon = "chevron.left.forwardslash.chevron.right"
    static let imageIcon = "photo"
    static let videoIcon = "film"
    static let audioIcon = "waveform"
    static let archiveIcon = "archivebox.fill"
    
    // Navigation
    static let upIcon = "chevron.up"
    static let backIcon = "chevron.left"
    static let forwardIcon = "chevron.right"
    static let separatorIcon = "chevron.right"
    
    static var allIcons: [String: String] {
        [
            "home": homeIcon,
            "root": rootIcon,
            "folder": folderIcon,
            "applications": applicationsIcon,
            "documents": documentsIcon,
            "desktop": desktopIcon,
            "downloads": downloadsIcon,
            "pictures": picturesIcon,
            "music": musicIcon,
            "movies": moviesIcon,
            "library": libraryIcon,
            "pdf": pdfIcon,
            "text": textIcon,
            "code": codeIcon,
            "image": imageIcon,
            "video": videoIcon,
            "audio": audioIcon,
            "archive": archiveIcon,
            "up": upIcon,
            "back": backIcon,
            "forward": forwardIcon,
            "separator": separatorIcon
        ]
    }
    
    static func getIcon(named name: String) -> String? {
        allIcons[name]
    }
    
    static func iconForFolder(named name: String) -> String {
        switch name.lowercased() {
        case "applications": return applicationsIcon
        case "documents": return documentsIcon
        case "desktop": return desktopIcon
        case "downloads": return downloadsIcon
        case "pictures": return picturesIcon
        case "music": return musicIcon
        case "movies": return moviesIcon
        case "library": return libraryIcon
        default: return folderIcon
        }
    }
    
    static func iconForFile(named name: String) -> String {
        let ext = (name as NSString).pathExtension.lowercased()
        
        switch ext {
        case "pdf": return pdfIcon
        case "txt", "md": return textIcon
        case "swift", "js", "py", "java": return codeIcon
        case "jpg", "jpeg", "png", "gif": return imageIcon
        case "mp4", "mov", "avi": return videoIcon
        case "mp3", "wav", "m4a": return audioIcon
        case "zip", "tar", "gz": return archiveIcon
        default: return "doc"
        }
    }
}
