import Foundation

/// Title bar creation operation
/// Handles instantiation and initialization of title bar components
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarCreateOperation {
    
    /// Creates a new title bar with default configuration
    public static func createDefault() -> TitleBarConfiguration {
        return TitleBarConfiguration(
            title: "Untitled",
            height: 44.0,
            showsButtons: true,
            style: .default
        )
    }
    
    /// Creates a new title bar with custom configuration
    public static func create(with config: TitleBarConfiguration) -> Result<TitleBarInstance, TitleBarError> {
        guard config.height >= 22.0 && config.height <= 100.0 else {
            return .failure(.invalidHeight(config.height))
        }
        
        let instance = TitleBarInstance(configuration: config)
        return .success(instance)
    }
    
    /// Creates a title bar from template
    public static func createFromTemplate(_ template: TitleBarTemplate) -> TitleBarInstance {
        let config = template.generateConfiguration()
        return TitleBarInstance(configuration: config)
    }
}

/// Title bar configuration for creation
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarConfiguration {
    public var title: String
    public var height: CGFloat
    public var showsButtons: Bool
    public var style: TitleBarStyle
    
    public enum TitleBarStyle {
        case `default`
        case unified
        case transparent
        case custom
    }
}

/// Title bar instance
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public class TitleBarInstance {
    public let id: UUID
    public var configuration: TitleBarConfiguration
    
    public init(configuration: TitleBarConfiguration) {
        self.id = UUID()
        self.configuration = configuration
    }
}

/// Title bar template
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public protocol TitleBarTemplate {
    func generateConfiguration() -> TitleBarConfiguration
}

/// Title bar error types
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public enum TitleBarError: Error {
    case invalidHeight(CGFloat)
    case invalidConfiguration
    case creationFailed
}
