import Foundation

// MARK: - PathBar Preview

@available(macOS 10.15, iOS 13.0, *)
struct PathBarPreview {
    
    static func defaultPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        (PathBarModel.mock(), PathBarModel.mockPaths()[0])
    }
    
    static func compactPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        (PathBarGenerator.generateCompact(), PathBarModel.mockPaths()[0])
    }
    
    static func breadcrumbPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        (PathBarGenerator.generateBreadcrumb(), PathBarModel.mockPaths()[0])
    }
    
    static func deepPathPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        (PathBarModel.mock(), PathBarModel.mockPaths()[1])
    }
    
    static func rootPathPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        (PathBarModel.mock(), PathBarModel.mockPaths()[2])
    }
    
    static func filePathPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        (PathBarModel.mock(), PathBarModel.mockPaths()[3])
    }
    
    static func homeOnlyPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        let model = PathBarModel.mock()
        let segments = [PathBarModel.PathSegment(name: "~", path: "/Users/demo", icon: "house.fill", order: 0)]
        return (model, segments)
    }
    
    static func noIconsPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        var model = PathBarModel.mock()
        model.showsIcons = false
        return (model, PathBarModel.mockPaths()[0])
    }
    
    static func customSeparatorPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        var model = PathBarModel.mock()
        model.separator = "›"
        return (model, PathBarModel.mockPaths()[0])
    }
    
    static func darkPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        var model = PathBarModel.mock()
        model.backgroundColor = "#2D2D2D"
        model.textColor = "#E0E0E0"
        return (model, PathBarModel.mockPaths()[0])
    }
    
    static func truncatedPreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        var model = PathBarModel.mock()
        model.maxSegments = 3
        model.truncationMode = .middle
        return (model, PathBarModel.mockPaths()[1])
    }
    
    static func nonClickablePreview() -> (model: PathBarModel, segments: [PathBarModel.PathSegment]) {
        var model = PathBarModel.mock()
        model.clickableSegments = false
        return (model, PathBarModel.mockPaths()[0])
    }
    
    static func allConfigurations() -> [(name: String, model: PathBarModel, segments: [PathBarModel.PathSegment])] {
        [
            ("Default", defaultPreview().model, defaultPreview().segments),
            ("Compact", compactPreview().model, compactPreview().segments),
            ("Breadcrumb", breadcrumbPreview().model, breadcrumbPreview().segments),
            ("Deep Path", deepPathPreview().model, deepPathPreview().segments),
            ("Root Path", rootPathPreview().model, rootPathPreview().segments),
            ("File Path", filePathPreview().model, filePathPreview().segments),
            ("Home Only", homeOnlyPreview().model, homeOnlyPreview().segments),
            ("No Icons", noIconsPreview().model, noIconsPreview().segments),
            ("Custom Separator", customSeparatorPreview().model, customSeparatorPreview().segments),
            ("Dark", darkPreview().model, darkPreview().segments),
            ("Truncated", truncatedPreview().model, truncatedPreview().segments),
            ("Non-Clickable", nonClickablePreview().model, nonClickablePreview().segments)
        ]
    }
}
