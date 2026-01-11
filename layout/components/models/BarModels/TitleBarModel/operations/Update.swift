import Foundation

/// Title bar update operation
/// Handles modification and mutation of title bar properties
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarUpdateOperation {
    
    /// Updates title bar title
    public static func updateTitle(_ title: String, for id: UUID) -> Result<Void, TitleBarError> {
        guard let instance = TitleBarRegistry.shared.getInstance(id: id) else {
            return .failure(.invalidConfiguration)
        }
        
        instance.configuration.title = title
        return .success(())
    }
    
    /// Updates title bar height
    public static func updateHeight(_ height: CGFloat, for id: UUID) -> Result<Void, TitleBarError> {
        guard height >= 22.0 && height <= 100.0 else {
            return .failure(.invalidHeight(height))
        }
        
        guard let instance = TitleBarRegistry.shared.getInstance(id: id) else {
            return .failure(.invalidConfiguration)
        }
        
        instance.configuration.height = height
        return .success(())
    }
    
    /// Updates title bar configuration
    public static func updateConfiguration(_ config: TitleBarConfiguration, for id: UUID) -> Result<Void, TitleBarError> {
        guard let instance = TitleBarRegistry.shared.getInstance(id: id) else {
            return .failure(.invalidConfiguration)
        }
        
        instance.configuration = config
        return .success(())
    }
    
    /// Batch update multiple properties
    public static func batchUpdate(for id: UUID, updates: (inout TitleBarConfiguration) -> Void) -> Result<Void, TitleBarError> {
        guard let instance = TitleBarRegistry.shared.getInstance(id: id) else {
            return .failure(.invalidConfiguration)
        }
        
        var config = instance.configuration
        updates(&config)
        instance.configuration = config
        
        return .success(())
    }
}
