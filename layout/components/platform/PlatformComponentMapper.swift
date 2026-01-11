import Foundation

// MARK: - Cross-Platform UI Component Mapping

/// Maps layout components to platform-specific implementations
/// Supports iOS, tvOS, macOS, visionOS, and watchOS
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
struct PlatformComponentMapper {
    
    // MARK: - Platform Enum
    
    enum Platform: String, CaseIterable {
        case iOS        // UIKit
        case tvOS       // UIKit for TV
        case macOS      // AppKit
        case visionOS   // SwiftUI + RealityKit
        case watchOS    // WatchKit
        case swiftUI    // Cross-platform SwiftUI
        
        var description: String {
            switch self {
            case .iOS: return "iOS (UIKit)"
            case .tvOS: return "tvOS (UIKit for TV)"
            case .macOS: return "macOS (AppKit)"
            case .visionOS: return "visionOS (SwiftUI + RealityKit)"
            case .watchOS: return "watchOS (WatchKit)"
            case .swiftUI: return "SwiftUI (All Platforms)"
            }
        }
        
        var framework: String {
            switch self {
            case .iOS, .tvOS: return "UIKit"
            case .macOS: return "AppKit"
            case .visionOS: return "SwiftUI + RealityKit"
            case .watchOS: return "WatchKit"
            case .swiftUI: return "SwiftUI"
            }
        }
    }
    
    // MARK: - Component Types
    
    enum ComponentType: String, CaseIterable {
        // Bar Models
        case titleBar
        case statusBar
        case pathBar
        case toolbar
        case breadcrumbs
        
        // Panel Models
        case sidePanel
        case floatingPanel
        case previewPanel
        
        // Tab Models
        case tabs
        case verticalTabs
        
        // Control Models
        case buttons
        case chips
        case accordion
        case segmented
        case steppers
        
        // Display Models
        case badges
        case charts
        case feeds
        case widgets
        
        // Menu Models
        case contextMenu
        case dropdown
        case bentoMenu
        case hamburgerMenu
        
        // Legacy/Generic
        case navigation
        case category
        case panel
        case content
        case card
        case button
        case label
        case textField
        case imageView
        case scrollView
        case tableView
        case collectionView
        case stackView
        case progressView
        case slider
        case toggle
        case picker
        case searchBar
    }
    
    // MARK: - Component Mappings
    
    /// Get platform-specific component name
    static func componentName(for type: ComponentType, platform: Platform) -> String {
        switch platform {
        case .iOS:
            return iOSMapping[type] ?? "UIView"
        case .tvOS:
            return tvOSMapping[type] ?? "UIView"
        case .macOS:
            return macOSMapping[type] ?? "NSView"
        case .visionOS:
            return visionOSMapping[type] ?? "View"
        case .watchOS:
            return watchOSMapping[type] ?? "WKInterfaceObject"
        case .swiftUI:
            return swiftUIMapping[type] ?? "View"
        }
    }
    
    /// Get all mappings for a component
    static func allMappings(for type: ComponentType) -> [Platform: String] {
        [
            .iOS: componentName(for: type, platform: .iOS),
            .tvOS: componentName(for: type, platform: .tvOS),
            .macOS: componentName(for: type, platform: .macOS),
            .visionOS: componentName(for: type, platform: .visionOS),
            .watchOS: componentName(for: type, platform: .watchOS),
            .swiftUI: componentName(for: type, platform: .swiftUI)
        ]
    }
    
    // MARK: - iOS Mappings (UIKit)
    
    private static let iOSMapping: [ComponentType: String] = [
        .titleBar: "UINavigationBar",
        .statusBar: "UILabel (in Container)",
        .pathBar: "UIView (Breadcrumbs)",
        .toolbar: "UIToolbar",
        .breadcrumbs: "UIStackView (Breadcrumbs)",
        .sidePanel: "UIViewController (Drawer)",
        .floatingPanel: "UIViewController (Popover)",
        .previewPanel: "QLPreviewController",
        .tabs: "UITabBarController",
        .verticalTabs: "UIStackView (Custom)",
        .buttons: "UIButton",
        .chips: "UIView (Custom Chip)",
        .accordion: "UITableView (Expandable)",
        .segmented: "UISegmentedControl",
        .steppers: "UIStepper",
        .badges: "UIView (Badge)",
        .charts: "Charts Framework",
        .feeds: "UICollectionView (Feed)",
        .widgets: "WidgetKit",
        .contextMenu: "UIContextMenuInteraction",
        .dropdown: "UIMenu",
        .bentoMenu: "UIView (Grid Menu)",
        .hamburgerMenu: "UIButton + UIMenu",
        .navigation: "UITabBar / UISplitViewController",
        .category: "UITableView",
        .panel: "UIViewController (Modal)",
        .content: "UIViewController",
        .card: "UIView (Custom)",
        .button: "UIButton",
        .label: "UILabel",
        .textField: "UITextField",
        .imageView: "UIImageView",
        .scrollView: "UIScrollView",
        .tableView: "UITableView",
        .collectionView: "UICollectionView",
        .stackView: "UIStackView",
        .progressView: "UIProgressView",
        .slider: "UISlider",
        .toggle: "UISwitch",
        .picker: "UIPickerView",
        .searchBar: "UISearchBar"
    ]
    
    // MARK: - tvOS Mappings (UIKit for TV)
    
    private static let tvOSMapping: [ComponentType: String] = [
        .titleBar: "UINavigationBar",
        .statusBar: "UILabel",
        .pathBar: "UIStackView (Breadcrumbs)",
        .toolbar: "UIToolbar",
        .breadcrumbs: "UIStackView (Breadcrumbs)",
        .sidePanel: "UISplitViewController (Sidebar)",
        .floatingPanel: "UIViewController (Modal)",
        .previewPanel: "UIView (Preview)",
        .tabs: "UITabBarController",
        .verticalTabs: "UICollectionView (Vertical)",
        .buttons: "UIButton (Focus)",
        .chips: "UIView (Custom)",
        .accordion: "UITableView (Expandable)",
        .segmented: "UISegmentedControl",
        .steppers: "UIStepper",
        .badges: "UIView (Badge)",
        .charts: "Charts Framework",
        .feeds: "UICollectionView (Feed)",
        .widgets: "UIView (Widget)",
        .contextMenu: "UIMenu",
        .dropdown: "UIMenu",
        .bentoMenu: "UICollectionView (Grid)",
        .hamburgerMenu: "UIMenu",
        .navigation: "UITabBar / UISplitViewController",
        .category: "UICollectionView",
        .panel: "UIViewController (Modal)",
        .content: "UIViewController",
        .card: "UIView (Custom)",
        .button: "UIButton",
        .label: "UILabel",
        .textField: "UITextField",
        .imageView: "UIImageView",
        .scrollView: "UIScrollView",
        .tableView: "UITableView",
        .collectionView: "UICollectionView",
        .stackView: "UIStackView",
        .progressView: "UIProgressView",
        .slider: "UISlider",
        .toggle: "UISwitch",
        .picker: "UIPickerView",
        .searchBar: "UISearchBar"
    ]
    
    // MARK: - macOS Mappings (AppKit)
    
    private static let macOSMapping: [ComponentType: String] = [
        .titleBar: "NSWindow.titlebarView",
        .statusBar: "NSTextField (Status)",
        .pathBar: "NSPathControl",
        .toolbar: "NSToolbar",
        .breadcrumbs: "NSPathControl",
        .sidePanel: "NSSplitViewItem",
        .floatingPanel: "NSPanel",
        .previewPanel: "QLPreviewPanel",
        .tabs: "NSTabViewController",
        .verticalTabs: "NSOutlineView (Sidebar)",
        .buttons: "NSButton",
        .chips: "NSView (Custom Chip)",
        .accordion: "NSOutlineView",
        .segmented: "NSSegmentedControl",
        .steppers: "NSStepper",
        .badges: "NSView (Badge)",
        .charts: "Charts Framework",
        .feeds: "NSCollectionView (Feed)",
        .widgets: "WidgetKit",
        .contextMenu: "NSMenu",
        .dropdown: "NSPopUpButton",
        .bentoMenu: "NSMenu (Grid)",
        .hamburgerMenu: "NSMenu",
        .navigation: "NSSplitViewController / NSOutlineView",
        .category: "NSOutlineView / NSTableView",
        .panel: "NSPanel",
        .content: "NSViewController",
        .card: "NSView (Custom)",
        .button: "NSButton",
        .label: "NSTextField (non-editable)",
        .textField: "NSTextField",
        .imageView: "NSImageView",
        .scrollView: "NSScrollView",
        .tableView: "NSTableView",
        .collectionView: "NSCollectionView",
        .stackView: "NSStackView",
        .progressView: "NSProgressIndicator",
        .slider: "NSSlider",
        .toggle: "NSButton (checkbox)",
        .picker: "NSPopUpButton",
        .searchBar: "NSSearchField"
    ]
    
    // MARK: - visionOS Mappings (SwiftUI + RealityKit)
    
    private static let visionOSMapping: [ComponentType: String] = [
        .titleBar: "Ornament / ToolbarItem",
        .statusBar: "Text (Status)",
        .pathBar: "HStack (Breadcrumbs)",
        .toolbar: "Toolbar",
        .breadcrumbs: "HStack (Breadcrumbs)",
        .sidePanel: "NavigationSplitView",
        .floatingPanel: "WindowGroup (Volume)",
        .previewPanel: "QuickLookPreview",
        .tabs: "TabView",
        .verticalTabs: "List (Sidebar)",
        .buttons: "Button (3D)",
        .chips: "HStack (Custom Chip)",
        .accordion: "DisclosureGroup",
        .segmented: "Picker (Segmented)",
        .steppers: "Stepper",
        .badges: "ZStack (Badge)",
        .charts: "Charts Framework",
        .feeds: "ScrollView (Feed)",
        .widgets: "WidgetKit",
        .contextMenu: "ContextMenu",
        .dropdown: "Menu",
        .bentoMenu: "Grid (Menu)",
        .hamburgerMenu: "Menu",
        .navigation: "NavigationSplitView",
        .category: "List",
        .panel: "Sheet / Popover",
        .content: "View (Custom)",
        .card: "VStack / HStack (Custom)",
        .button: "Button",
        .label: "Text",
        .textField: "TextField",
        .imageView: "Image / Model3D",
        .scrollView: "ScrollView",
        .tableView: "List",
        .collectionView: "LazyVGrid / LazyHGrid",
        .stackView: "VStack / HStack / ZStack",
        .progressView: "ProgressView",
        .slider: "Slider",
        .toggle: "Toggle",
        .picker: "Picker",
        .searchBar: "TextField (searchable)"
    ]
    
    // MARK: - watchOS Mappings (WatchKit)
    
    private static let watchOSMapping: [ComponentType: String] = [
        .titleBar: "NavigationBarTitle",
        .statusBar: "Text",
        .pathBar: "NavigationBarTitle",
        .toolbar: "ToolbarItemGroup",
        .breadcrumbs: "NavigationLink",
        .sidePanel: "NavigationView",
        .floatingPanel: "Sheet",
        .previewPanel: "View (Preview)",
        .tabs: "TabView",
        .verticalTabs: "List",
        .buttons: "Button",
        .chips: "HStack (Chip)",
        .accordion: "DisclosureGroup",
        .segmented: "Picker",
        .steppers: "Stepper",
        .badges: "ZStack (Badge)",
        .charts: "Charts Framework",
        .feeds: "ScrollView",
        .widgets: "WidgetKit",
        .contextMenu: "ContextMenu",
        .dropdown: "Picker",
        .bentoMenu: "Grid",
        .hamburgerMenu: "Menu",
        .navigation: "NavigationView",
        .category: "List",
        .panel: "Sheet",
        .content: "View",
        .card: "VStack",
        .button: "Button",
        .label: "Text",
        .textField: "TextField",
        .imageView: "Image",
        .scrollView: "ScrollView",
        .tableView: "List",
        .collectionView: "LazyVGrid",
        .stackView: "VStack / HStack",
        .progressView: "ProgressView",
        .slider: "Slider",
        .toggle: "Toggle",
        .picker: "Picker",
        .searchBar: "TextField"
    ]
    
    // MARK: - SwiftUI Mappings (Cross-Platform)
    
    private static let swiftUIMapping: [ComponentType: String] = [
        .titleBar: "NavigationView / ToolbarItem",
        .statusBar: "HStack / Text (Status)",
        .pathBar: "HStack (Breadcrumbs)",
        .toolbar: "Toolbar",
        .breadcrumbs: "HStack (Breadcrumbs)",
        .sidePanel: "NavigationSplitView",
        .floatingPanel: "Popover",
        .previewPanel: "QuickLookPreview",
        .tabs: "TabView",
        .verticalTabs: "List (Sidebar)",
        .buttons: "Button",
        .chips: "HStack (Custom Chip)",
        .accordion: "DisclosureGroup",
        .segmented: "Picker (Segmented)",
        .steppers: "Stepper",
        .badges: "ZStack (Badge)",
        .charts: "Charts Framework",
        .feeds: "ScrollView (Feed)",
        .widgets: "WidgetKit",
        .contextMenu: "ContextMenu",
        .dropdown: "Menu / Picker",
        .bentoMenu: "LazyVGrid (Menu)",
        .hamburgerMenu: "Menu",
        .navigation: "NavigationView / TabView",
        .category: "List / OutlineGroup",
        .panel: "Sheet / Popover",
        .content: "View (Custom)",
        .card: "VStack / HStack (Custom)",
        .button: "Button",
        .label: "Text",
        .textField: "TextField",
        .imageView: "Image",
        .scrollView: "ScrollView",
        .tableView: "List",
        .collectionView: "LazyVGrid / LazyHGrid",
        .stackView: "VStack / HStack / ZStack",
        .progressView: "ProgressView",
        .slider: "Slider",
        .toggle: "Toggle",
        .picker: "Picker",
        .searchBar: "TextField (searchable)"
    ]
}

// MARK: - Component Property Mapping

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
extension PlatformComponentMapper {
    
    /// Map common properties to platform-specific equivalents
    struct PropertyMapping {
        let iOS: String
        let tvOS: String
        let macOS: String
        let visionOS: String
        let watchOS: String
        let swiftUI: String
    }
    
    static let propertyMappings: [String: PropertyMapping] = [
        "backgroundColor": PropertyMapping(
            swiftUI: ".background(Color)",
            uiKit: ".backgroundColor",
            appKit: ".backgroundColor"
        ),
        "foregroundColor": PropertyMapping(
            swiftUI: ".foregroundColor(Color)",
            uiKit: ".textColor",
            appKit: ".textColor"
        ),
        "font": PropertyMapping(
            swiftUI: ".font(Font)",
            uiKit: ".font",
            appKit: ".font"
        ),
        "frame": PropertyMapping(
            swiftUI: ".frame(width:height:)",
            uiKit: ".frame",
            appKit: ".frame"
        ),
        "padding": PropertyMapping(
            swiftUI: ".padding()",
            uiKit: ".layoutMargins",
            appKit: ".edgeInsets"
        ),
        "cornerRadius": PropertyMapping(
            swiftUI: ".cornerRadius()",
            uiKit: ".layer.cornerRadius",
            appKit: ".layer.cornerRadius"
        ),
        "shadow": PropertyMapping(
            swiftUI: ".shadow(radius:)",
            uiKit: ".layer.shadowRadius",
            appKit: ".shadow"
        ),
        "opacity": PropertyMapping(
            swiftUI: ".opacity()",
            uiKit: ".alpha",
            appKit: ".alphaValue"
        ),
        "hidden": PropertyMapping(
            swiftUI: ".hidden() or if condition",
            uiKit: ".isHidden",
            appKit: ".isHidden"
        ),
        "disabled": PropertyMapping(
            swiftUI: ".disabled()",
            uiKit: ".isEnabled = false",
            appKit: ".isEnabled = false"
        )
    ]
    
    static func propertyMapping(for property: String, platform: Platform) -> String? {
        guard let mapping = propertyMappings[property] else { return nil }
        
        switch platform {
        case .swiftUI: return mapping.swiftUI
        case .uiKit: return mapping.uiKit
        case .appKit: return mapping.appKit
        }
    }
}

// MARK: - Layout System Mapping

extension PlatformComponentMapper {
    
    enum LayoutSystem {
        case swiftUI        // VStack, HStack, ZStack
        case uiKit          // Auto Layout, UIStackView
        case appKit         // Auto Layout, NSStackView
        case frame          // Manual frame calculation
    }
    
    static func recommendedLayout(for platform: Platform) -> LayoutSystem {
        switch platform {
        case .swiftUI: return .swiftUI
        case .uiKit: return .uiKit
        case .appKit: return .appKit
        }
    }
    
    static let layoutExamples: [Platform: String] = [
        .swiftUI: """
        VStack(spacing: 16) {
            Text("Title")
            HStack {
                Button("Action") { }
                Spacer()
            }
        }
        """,
        .uiKit: """
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        """,
        .appKit: """
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
        """
    ]
}

// MARK: - Code Generator

extension PlatformComponentMapper {
    
    /// Generate platform-specific code for component
    static func generateCode(
        for type: ComponentType,
        platform: Platform,
        properties: [String: Any]
    ) -> String {
        let componentName = self.componentName(for: type, platform: platform)
        
        switch platform {
        case .swiftUI:
            return generateSwiftUICode(componentName: componentName, properties: properties)
        case .uiKit:
            return generateUIKitCode(componentName: componentName, properties: properties)
        case .appKit:
            return generateAppKitCode(componentName: componentName, properties: properties)
        }
    }
    
    private static func generateSwiftUICode(componentName: String, properties: [String: Any]) -> String {
        var code = "\(componentName) {\n"
        
        if let text = properties["text"] as? String {
            code += "    Text(\"\(text)\")\n"
        }
        
        code += "}\n"
        
        // Add modifiers
        if let bgColor = properties["backgroundColor"] as? String {
            code += ".background(Color(hex: \"\(bgColor)\"))\n"
        }
        
        if let width = properties["width"] as? Double,
           let height = properties["height"] as? Double {
            code += ".frame(width: \(width), height: \(height))\n"
        }
        
        return code
    }
    
    private static func generateUIKitCode(componentName: String, properties: [String: Any]) -> String {
        var code = "let view = \(componentName)()\n"
        
        if let bgColor = properties["backgroundColor"] as? String {
            code += "view.backgroundColor = UIColor(hex: \"\(bgColor)\")\n"
        }
        
        if let width = properties["width"] as? Double,
           let height = properties["height"] as? Double {
            code += "view.frame = CGRect(x: 0, y: 0, width: \(width), height: \(height))\n"
        }
        
        return code
    }
    
    private static func generateAppKitCode(componentName: String, properties: [String: Any]) -> String {
        var code = "let view = \(componentName)()\n"
        
        if let bgColor = properties["backgroundColor"] as? String {
            code += "view.wantsLayer = true\n"
            code += "view.layer?.backgroundColor = NSColor(hex: \"\(bgColor)\").cgColor\n"
        }
        
        if let width = properties["width"] as? Double,
           let height = properties["height"] as? Double {
            code += "view.frame = NSRect(x: 0, y: 0, width: \(width), height: \(height))\n"
        }
        
        return code
    }
}

// MARK: - Migration Helper

extension PlatformComponentMapper {
    
    /// Generate migration guide from one platform to another
    static func migrationGuide(
        from sourcePlatform: Platform,
        to targetPlatform: Platform,
        component: ComponentType
    ) -> String {
        let sourceComponent = componentName(for: component, platform: sourcePlatform)
        let targetComponent = componentName(for: component, platform: targetPlatform)
        
        return """
        Migration Guide: \(component.rawValue)
        
        From: \(sourcePlatform.description)
        Component: \(sourceComponent)
        
        To: \(targetPlatform.description)
        Component: \(targetComponent)
        
        Key Differences:
        \(migrationDifferences(from: sourcePlatform, to: targetPlatform))
        
        Example Code:
        \(layoutExamples[targetPlatform] ?? "")
        """
    }
    
    private static func migrationDifferences(from source: Platform, to target: Platform) -> String {
        switch (source, target) {
        case (.uiKit, .swiftUI):
            return """
            - Replace imperative setup with declarative modifiers
            - Use @State, @Binding for state management
            - Replace delegates with closures
            - Use ViewModifiers instead of subclassing
            """
        case (.appKit, .swiftUI):
            return """
            - Replace NSViewController with View protocol
            - Use @StateObject for view models
            - Replace NSView hierarchy with VStack/HStack
            - Use @Environment for app-wide state
            """
        case (.swiftUI, .uiKit):
            return """
            - Replace modifiers with property setters
            - Implement delegates for callbacks
            - Use UIHostingController to wrap SwiftUI
            - Manage state manually or with Combine
            """
        default:
            return "Platform-specific migration required"
        }
    }
}
