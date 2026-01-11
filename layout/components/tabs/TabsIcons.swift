import Foundation

// MARK: - Tabs Icons

@available(macOS 10.15, iOS 13.0, *)
struct TabsIcons {
    
    // MARK: - Tab Style Icons
    
    static let barIcon = "rectangle.split.3x1"
    static let pillsIcon = "capsule"
    static let segmentsIcon = "square.split.3x1"
    
    // MARK: - Control Icons
    
    static let closeIcon = "xmark"
    static let closeCircleIcon = "xmark.circle.fill"
    static let addIcon = "plus"
    static let addCircleIcon = "plus.circle"
    
    static let pinIcon = "pin"
    static let pinFillIcon = "pin.fill"
    static let unpinIcon = "pin.slash"
    
    static let moveLeftIcon = "chevron.left"
    static let moveRightIcon = "chevron.right"
    static let reorderIcon = "arrow.up.arrow.down"
    
    // MARK: - Common Tab Icons
    
    static let homeIcon = "house.fill"
    static let documentIcon = "doc.text"
    static let folderIcon = "folder"
    static let settingsIcon = "gear"
    static let profileIcon = "person.circle"
    static let messageIcon = "message"
    static let notificationIcon = "bell"
    static let calendarIcon = "calendar"
    static let taskIcon = "checkmark.circle"
    static let searchIcon = "magnifyingglass"
    static let favoriteIcon = "star.fill"
    static let downloadIcon = "arrow.down.circle"
    static let uploadIcon = "arrow.up.circle"
    static let shareIcon = "square.and.arrow.up"
    
    // MARK: - Category Groups
    
    static var styleIcons: [String: String] {
        [
            "bar": barIcon,
            "pills": pillsIcon,
            "segments": segmentsIcon
        ]
    }
    
    static var controlIcons: [String: String] {
        [
            "close": closeIcon,
            "closeCircle": closeCircleIcon,
            "add": addIcon,
            "addCircle": addCircleIcon,
            "pin": pinIcon,
            "pinFill": pinFillIcon,
            "unpin": unpinIcon,
            "moveLeft": moveLeftIcon,
            "moveRight": moveRightIcon,
            "reorder": reorderIcon
        ]
    }
    
    static var commonIcons: [String: String] {
        [
            "home": homeIcon,
            "document": documentIcon,
            "folder": folderIcon,
            "settings": settingsIcon,
            "profile": profileIcon,
            "message": messageIcon,
            "notification": notificationIcon,
            "calendar": calendarIcon,
            "task": taskIcon,
            "search": searchIcon,
            "favorite": favoriteIcon,
            "download": downloadIcon,
            "upload": uploadIcon,
            "share": shareIcon
        ]
    }
    
    // MARK: - All Icons
    
    static var allIcons: [String: String] {
        var icons: [String: String] = [:]
        icons.merge(styleIcons) { (_, new) in new }
        icons.merge(controlIcons) { (_, new) in new }
        icons.merge(commonIcons) { (_, new) in new }
        return icons
    }
    
    // MARK: - Helper Methods
    
    static func getIcon(named name: String) -> String? {
        allIcons[name]
    }
    
    static func iconExists(named name: String) -> Bool {
        allIcons[name] != nil
    }
}
