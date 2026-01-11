import Foundation

// MARK: - StatusBar Preview

@available(macOS 10.15, iOS 13.0, *)
struct StatusBarPreview {
    
    static func defaultPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        (StatusBarModel.mock(), StatusBarModel.mockItems())
    }
    
    static func minimalPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        (StatusBarGenerator.generateMinimal(), Array(StatusBarModel.mockItems().prefix(2)))
    }
    
    static func darkPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        (StatusBarGenerator.generateDark(), StatusBarModel.mockItems())
    }
    
    static func codeEditorPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        let model = StatusBarModel.mock()
        let items = [
            StatusBarModel.StatusItem(position: .leading, icon: "text.alignleft", text: "Ln 42, Col 8", order: 0),
            StatusBarModel.StatusItem(position: .leading, text: "UTF-8", order: 1),
            StatusBarModel.StatusItem(position: .leading, text: "Swift", order: 2),
            StatusBarModel.StatusItem(position: .trailing, icon: "checkmark.circle", text: "No Issues", order: 0)
        ]
        return (model, items)
    }
    
    static func systemMonitorPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        let model = StatusBarModel.mock()
        let items = [
            StatusBarModel.StatusItem(position: .leading, icon: "flame", text: "CPU: 24%", order: 0),
            StatusBarModel.StatusItem(position: .leading, icon: "memorychip", text: "RAM: 8.2GB", order: 1),
            StatusBarModel.StatusItem(position: .trailing, icon: "internaldrive", text: "512GB Free", order: 0)
        ]
        return (model, items)
    }
    
    static func progressPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        var model = StatusBarModel.mock()
        model.showsProgress = true
        let items = [
            StatusBarModel.StatusItem(position: .center, icon: "arrow.down.circle", text: "Downloading... 45%", order: 0)
        ]
        return (model, items)
    }
    
    static func browserPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        let model = StatusBarModel.mock()
        let items = [
            StatusBarModel.StatusItem(position: .leading, icon: "checkmark.circle", text: "Secure Connection", order: 0),
            StatusBarModel.StatusItem(position: .trailing, icon: "arrow.down.circle", text: "3 Downloads", order: 0)
        ]
        return (model, items)
    }
    
    static func mobilePreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        var model = StatusBarModel.mock()
        model.height = 44
        let items = [
            StatusBarModel.StatusItem(position: .leading, icon: "wifi", text: "Wi-Fi", order: 0),
            StatusBarModel.StatusItem(position: .center, icon: "clock", text: "14:32", order: 0),
            StatusBarModel.StatusItem(position: .trailing, icon: "battery.100", text: "100%", order: 0)
        ]
        return (model, items)
    }
    
    static func errorPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        var model = StatusBarModel.mock()
        model.backgroundColor = "#FFF3CD"
        let items = [
            StatusBarModel.StatusItem(position: .center, icon: "exclamationmark.triangle", text: "3 Warnings, 1 Error", order: 0)
        ]
        return (model, items)
    }
    
    static func successPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        var model = StatusBarModel.mock()
        model.backgroundColor = "#D4EDDA"
        let items = [
            StatusBarModel.StatusItem(position: .center, icon: "checkmark.circle", text: "Build Successful", order: 0)
        ]
        return (model, items)
    }
    
    static func emptyPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        (StatusBarModel.mock(), [])
    }
    
    static func fullPreview() -> (model: StatusBarModel, items: [StatusBarModel.StatusItem]) {
        let model = StatusBarModel.mock()
        let items: [StatusBarModel.StatusItem] = [
            StatusBarModel.StatusItem(position: .leading, icon: "text.alignleft", text: "1234 lines", order: 0),
            StatusBarModel.StatusItem(position: .leading, icon: "flame", text: "CPU: 12%", order: 1),
            StatusBarModel.StatusItem(position: .leading, icon: "memorychip", text: "RAM: 4GB", order: 2),
            StatusBarModel.StatusItem(position: .center, text: "Ready", order: 0),
            StatusBarModel.StatusItem(position: .trailing, icon: "clock", text: "14:32", order: 0),
            StatusBarModel.StatusItem(position: .trailing, icon: "wifi", text: "Connected", order: 1),
            StatusBarModel.StatusItem(position: .trailing, icon: "battery.100", text: "100%", order: 2)
        ]
        return (model, items)
    }
    
    static func allConfigurations() -> [(name: String, model: StatusBarModel, items: [StatusBarModel.StatusItem])] {
        [
            ("Default", defaultPreview().model, defaultPreview().items),
            ("Minimal", minimalPreview().model, minimalPreview().items),
            ("Dark", darkPreview().model, darkPreview().items),
            ("Code Editor", codeEditorPreview().model, codeEditorPreview().items),
            ("System Monitor", systemMonitorPreview().model, systemMonitorPreview().items),
            ("Progress", progressPreview().model, progressPreview().items),
            ("Browser", browserPreview().model, browserPreview().items),
            ("Mobile", mobilePreview().model, mobilePreview().items),
            ("Error", errorPreview().model, errorPreview().items),
            ("Success", successPreview().model, successPreview().items),
            ("Empty", emptyPreview().model, emptyPreview().items),
            ("Full", fullPreview().model, fullPreview().items)
        ]
    }
}
