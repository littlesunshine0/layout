import Foundation

// MARK: - PreviewPanel Preview

@available(macOS 10.15, iOS 13.0, *)
struct PreviewPanelPreview {
    
    // MARK: - Configuration 1: Default Preview
    
    static func defaultPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelModel.mock()
        let items = PreviewPanelModel.mockItems()
        return (model, items)
    }
    
    // MARK: - Configuration 2: Compact Preview
    
    static func compactPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelGenerator.generateCompact()
        let items = Array(PreviewPanelModel.mockItems().prefix(3))
        return (model, items)
    }
    
    // MARK: - Configuration 3: Fullscreen Preview
    
    static func fullscreenPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelGenerator.generateFullscreen()
        let items = PreviewPanelModel.mockItems()
        return (model, items)
    }
    
    // MARK: - Configuration 4: Editor Mode
    
    static func editorPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelGenerator.generateEditor()
        let items = PreviewPanelModel.mockItems().filter { $0.type == .image || $0.type == .code }
        return (model, items)
    }
    
    // MARK: - Configuration 5: Image Gallery
    
    static func imageGalleryPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelModel(
            width: 1000,
            height: 700,
            contentPadding: 20,
            toolbarHeight: 50,
            backgroundColor: "#F0F0F0",
            showsToolbar: true,
            showsMetadata: true,
            showsZoomControls: true,
            minZoom: 0.1,
            maxZoom: 10.0,
            defaultZoom: 1.0,
            allowsEditing: false
        )
        let items = PreviewPanelGenerator.generateBatchItems(count: 10, type: .image)
        return (model, items)
    }
    
    // MARK: - Configuration 6: Video Player
    
    static func videoPlayerPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelModel(
            width: 1280,
            height: 720,
            contentPadding: 0,
            toolbarHeight: 60,
            backgroundColor: "#000000",
            showsToolbar: true,
            showsMetadata: false,
            showsZoomControls: false,
            minZoom: 1.0,
            maxZoom: 1.0,
            defaultZoom: 1.0,
            allowsEditing: false
        )
        let items = PreviewPanelModel.mockItems().filter { $0.type == .video }
        return (model, items)
    }
    
    // MARK: - Configuration 7: Audio Player
    
    static func audioPlayerPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelModel(
            width: 600,
            height: 400,
            contentPadding: 16,
            toolbarHeight: 70,
            backgroundColor: "#1E1E1E",
            showsToolbar: true,
            showsMetadata: true,
            showsZoomControls: false,
            minZoom: 1.0,
            maxZoom: 1.0,
            defaultZoom: 1.0,
            allowsEditing: false
        )
        let items = PreviewPanelModel.mockItems().filter { $0.type == .audio }
        return (model, items)
    }
    
    // MARK: - Configuration 8: Document Viewer
    
    static func documentViewerPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelModel(
            width: 900,
            height: 1200,
            contentPadding: 32,
            toolbarHeight: 44,
            backgroundColor: "#FAFAFA",
            showsToolbar: true,
            showsMetadata: true,
            showsZoomControls: true,
            minZoom: 0.5,
            maxZoom: 3.0,
            defaultZoom: 1.0,
            allowsEditing: false
        )
        let items = PreviewPanelModel.mockItems().filter { $0.type == .pdf || $0.type == .document }
        return (model, items)
    }
    
    // MARK: - Configuration 9: Code Editor
    
    static func codeEditorPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelModel(
            width: 1200,
            height: 900,
            contentPadding: 0,
            toolbarHeight: 40,
            backgroundColor: "#282C34",
            showsToolbar: true,
            showsMetadata: true,
            showsZoomControls: false,
            minZoom: 0.5,
            maxZoom: 2.0,
            defaultZoom: 1.0,
            allowsEditing: true
        )
        let items = PreviewPanelModel.mockItems().filter { $0.type == .code || $0.type == .markdown }
        return (model, items)
    }
    
    // MARK: - Configuration 10: Minimal Preview
    
    static func minimalPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelModel(
            width: 300,
            height: 300,
            contentPadding: 8,
            toolbarHeight: 0,
            backgroundColor: "#FFFFFF",
            showsToolbar: false,
            showsMetadata: false,
            showsZoomControls: false,
            minZoom: 1.0,
            maxZoom: 1.0,
            defaultZoom: 1.0,
            allowsEditing: false
        )
        let items = Array(PreviewPanelModel.mockItems().prefix(1))
        return (model, items)
    }
    
    // MARK: - Configuration 11: Multi-Type Preview
    
    static func multiTypePreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelModel.mock()
        let items = PreviewPanelModel.mockItems()
        return (model, items)
    }
    
    // MARK: - Configuration 12: High-Res Preview
    
    static func highResPreview() -> (model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem]) {
        let model = PreviewPanelModel(
            width: 2560,
            height: 1440,
            contentPadding: 40,
            toolbarHeight: 60,
            backgroundColor: "#FFFFFF",
            showsToolbar: true,
            showsMetadata: true,
            showsZoomControls: true,
            minZoom: 0.05,
            maxZoom: 20.0,
            defaultZoom: 1.0,
            allowsEditing: true
        )
        let items = PreviewPanelModel.mockItems()
        return (model, items)
    }
    
    // MARK: - All Configurations
    
    static func allConfigurations() -> [(name: String, model: PreviewPanelModel, items: [PreviewPanelModel.PreviewItem])] {
        [
            ("Default", defaultPreview().model, defaultPreview().items),
            ("Compact", compactPreview().model, compactPreview().items),
            ("Fullscreen", fullscreenPreview().model, fullscreenPreview().items),
            ("Editor", editorPreview().model, editorPreview().items),
            ("Image Gallery", imageGalleryPreview().model, imageGalleryPreview().items),
            ("Video Player", videoPlayerPreview().model, videoPlayerPreview().items),
            ("Audio Player", audioPlayerPreview().model, audioPlayerPreview().items),
            ("Document Viewer", documentViewerPreview().model, documentViewerPreview().items),
            ("Code Editor", codeEditorPreview().model, codeEditorPreview().items),
            ("Minimal", minimalPreview().model, minimalPreview().items),
            ("Multi-Type", multiTypePreview().model, multiTypePreview().items),
            ("High-Res", highResPreview().model, highResPreview().items)
        ]
    }
}
