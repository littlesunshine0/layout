import Foundation

// MARK: - Multi-Platform Component Mapping

/// Maps layout components to platform-specific implementations
/// Supports iOS, tvOS, macOS, visionOS, and watchOS
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct PlatformMapper {
    
    // MARK: - Platform Enum
    
    public enum Platform: String, CaseIterable {
        case iOS
        case tvOS
        case macOS
        case visionOS
        case watchOS
        
        public var description: String {
            switch self {
            case .iOS: return "iOS (UIKit/SwiftUI)"
            case .tvOS: return "tvOS (UIKit for TV/SwiftUI)"
            case .macOS: return "macOS (AppKit/SwiftUI)"
            case .visionOS: return "visionOS (SwiftUI + RealityKit)"
            case .watchOS: return "watchOS (WatchKit/SwiftUI)"
            }
        }
        
        public var primaryFramework: String {
            switch self {
            case .iOS: return "UIKit"
            case .tvOS: return "UIKit"
            case .macOS: return "AppKit"
            case .visionOS: return "SwiftUI"
            case .watchOS: return "SwiftUI"
            }
        }
    }
    
    // MARK: - Component Categories
    
    public enum ComponentCategory: String, CaseIterable {
        case bars
        case panels
        case tabs
        case controls
        case displays
        case menus
        case navigation
        case cards
    }
    
    // MARK: - Component Mappings
    
    /// Get platform-specific component implementation
    public static func component(
        category: ComponentCategory,
        name: String,
        platform: Platform
    ) -> String {
        let key = "\(category.rawValue).\(name)"
        
        switch platform {
        case .iOS:
            return iOSMappings[key] ?? "UIView"
        case .tvOS:
            return tvOSMappings[key] ?? "UIView"
        case .macOS:
            return macOSMappings[key] ?? "NSView"
        case .visionOS:
            return visionOSMappings[key] ?? "View"
        case .watchOS:
            return watchOSMappings[key] ?? "View"
        }
    }
    
    // MARK: - iOS Mappings
    
    private static let iOSMappings: [String: String] = [
        // Bars
        "bars.titlebar": "UINavigationBar",
        "bars.statusbar": "UIView (Custom)",
        "bars.pathbar": "UIView (Custom)",
        "bars.toolbar": "UIToolbar",
        "bars.breadcrumbs": "UIView (Custom)",
        
        // Panels
        "panels.sidepanel": "UIViewController (Container)",
        "panels.floatingpanel": "UIViewController (Modal)",
        "panels.previewpanel": "QLPreviewController",
        
        // Tabs
        "tabs.tabs": "UITabBarController",
        "tabs.verticaltabs": "UITableView",
        
        // Controls
        "controls.buttons": "UIButton",
        "controls.chips": "UICollectionView",
        "controls.accordion": "UITableView",
        "controls.segmented": "UISegmentedControl",
        "controls.steppers": "UIStepper",
        
        // Displays
        "displays.badges": "UILabel",
        "displays.charts": "UIView (Charts)",
        "displays.feeds": "UITableView",
        "displays.widgets": "UIView (Custom)",
        
        // Menus
        "menus.context": "UIContextMenuConfiguration",
        "menus.dropdown": "UIMenu",
        "menus.bento": "UICollectionView",
        "menus.hamburger": "UIView (Custom)"
    ]
    
    // MARK: - tvOS Mappings
    
    private static let tvOSMappings: [String: String] = [
        // Bars
        "bars.titlebar": "UINavigationBar",
        "bars.statusbar": "UIView (Custom)",
        "bars.pathbar": "UIView (Custom)",
        "bars.toolbar": "UIToolbar",
        "bars.breadcrumbs": "UIView (Custom)",
        
        // Panels
        "panels.sidepanel": "UIViewController (Container)",
        "panels.floatingpanel": "UIViewController (Modal)",
        "panels.previewpanel": "UIViewController",
        
        // Tabs
        "tabs.tabs": "UITabBarController",
        "tabs.verticaltabs": "UITableView",
        
        // Controls
        "controls.buttons": "UIButton (tvOS Focus)",
        "controls.chips": "UICollectionView (Focus)",
        "controls.accordion": "UITableView (Focus)",
        "controls.segmented": "UISegmentedControl",
        "controls.steppers": "UIStepper",
        
        // Displays
        "displays.badges": "UILabel",
        "displays.charts": "UIView (Charts)",
        "displays.feeds": "UITableView (Focus)",
        "displays.widgets": "UIView (Custom)",
        
        // Menus
        "menus.context": "UIMenu",
        "menus.dropdown": "UIMenu",
        "menus.bento": "UICollectionView (Focus)",
        "menus.hamburger": "UIView (Custom)"
    ]
    
    // MARK: - macOS Mappings
    
    private static let macOSMappings: [String: String] = [
        // Bars
        "bars.titlebar": "NSWindow.titlebarView",
        "bars.statusbar": "NSView (Custom)",
        "bars.pathbar": "NSPathControl",
        "bars.toolbar": "NSToolbar",
        "bars.breadcrumbs": "NSPathControl",
        
        // Panels
        "panels.sidepanel": "NSSplitViewController",
        "panels.floatingpanel": "NSPanel",
        "panels.previewpanel": "QLPreviewPanel",
        
        // Tabs
        "tabs.tabs": "NSTabViewController",
        "tabs.verticaltabs": "NSOutlineView",
        
        // Controls
        "controls.buttons": "NSButton",
        "controls.chips": "NSCollectionView",
        "controls.accordion": "NSOutlineView",
        "controls.segmented": "NSSegmentedControl",
        "controls.steppers": "NSStepper",
        
        // Displays
        "displays.badges": "NSTextField",
        "displays.charts": "NSView (Charts)",
        "displays.feeds": "NSTableView",
        "displays.widgets": "NSView (Custom)",
        
        // Menus
        "menus.context": "NSMenu",
        "menus.dropdown": "NSPopUpButton",
        "menus.bento": "NSCollectionView",
        "menus.hamburger": "NSView (Custom)"
    ]
    
    // MARK: - visionOS Mappings
    
    private static let visionOSMappings: [String: String] = [
        // Bars
        "bars.titlebar": "Ornament / ToolbarItem",
        "bars.statusbar": "HStack (Ornament)",
        "bars.pathbar": "HStack (Breadcrumbs)",
        "bars.toolbar": "Toolbar",
        "bars.breadcrumbs": "HStack (Breadcrumbs)",
        
        // Panels
        "panels.sidepanel": "NavigationSplitView",
        "panels.floatingpanel": "WindowGroup (Volumetric)",
        "panels.previewpanel": "QuickLookPreview",
        
        // Tabs
        "tabs.tabs": "TabView",
        "tabs.verticaltabs": "List (3D Layout)",
        
        // Controls
        "controls.buttons": "Button (3D)",
        "controls.chips": "LazyVGrid (3D)",
        "controls.accordion": "DisclosureGroup (3D)",
        "controls.segmented": "Picker (Segmented)",
        "controls.steppers": "Stepper",
        
        // Displays
        "displays.badges": "Text (Badge)",
        "displays.charts": "Chart (SwiftUI)",
        "displays.feeds": "List (3D)",
        "displays.widgets": "WidgetKit (3D)",
        
        // Menus
        "menus.context": "contextMenu",
        "menus.dropdown": "Menu",
        "menus.bento": "LazyVGrid (3D)",
        "menus.hamburger": "Menu (3D)"
    ]
    
    // MARK: - watchOS Mappings
    
    private static let watchOSMappings: [String: String] = [
        // Bars
        "bars.titlebar": "NavigationView (Inline)",
        "bars.statusbar": "Text (Compact)",
        "bars.pathbar": "N/A",
        "bars.toolbar": "ToolbarItemGroup",
        "bars.breadcrumbs": "N/A",
        
        // Panels
        "panels.sidepanel": "N/A",
        "panels.floatingpanel": "Sheet",
        "panels.previewpanel": "QuickLookPreview",
        
        // Tabs
        "tabs.tabs": "TabView (Watch)",
        "tabs.verticaltabs": "List (Compact)",
        
        // Controls
        "controls.buttons": "Button (Watch)",
        "controls.chips": "N/A",
        "controls.accordion": "DisclosureGroup",
        "controls.segmented": "Picker",
        "controls.steppers": "Stepper",
        
        // Displays
        "displays.badges": "Text (Badge)",
        "displays.charts": "Chart (Compact)",
        "displays.feeds": "List (Compact)",
        "displays.widgets": "WidgetKit (Watch)",
        
        // Menus
        "menus.context": "contextMenu",
        "menus.dropdown": "Menu",
        "menus.bento": "N/A",
        "menus.hamburger": "Menu"
    ]
    
    // MARK: - Platform Availability
    
    /// Check if component is available on platform
    public static func isAvailable(
        category: ComponentCategory,
        name: String,
        platform: Platform
    ) -> Bool {
        let implementation = component(category: category, name: name, platform: platform)
        return !implementation.contains("N/A")
    }
    
    /// Get all available platforms for a component
    public static func availablePlatforms(
        category: ComponentCategory,
        name: String
    ) -> [Platform] {
        Platform.allCases.filter { platform in
            isAvailable(category: category, name: name, platform: platform)
        }
    }
}
