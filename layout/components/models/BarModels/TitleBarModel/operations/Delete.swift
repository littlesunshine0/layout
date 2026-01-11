import Foundation

/// Title bar delete operation
/// Handles removal and cleanup of title bar components
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarDeleteOperation {
    
    /// Deletes a title bar by identifier
    public static func delete(id: UUID) -> Result<Void, TitleBarError> {
        guard TitleBarRegistry.shared.getInstance(id: id) != nil else {
            return .failure(.invalidConfiguration)
        }
        
        TitleBarRegistry.shared.unregister(id: id)
        return .success(())
    }
    
    /// Deletes all title bars
    public static func deleteAll() -> Int {
        let instances = TitleBarRegistry.shared.getAllInstances()
        let count = instances.count
        
        instances.forEach { instance in
            TitleBarRegistry.shared.unregister(id: instance.id)
        }
        
        return count
    }
    
    /// Deletes title bars matching predicate
    public static func deleteWhere(predicate: (TitleBarInstance) -> Bool) -> Int {
        let instances = TitleBarRegistry.shared.getAllInstances().filter(predicate)
        
        instances.forEach { instance in
            TitleBarRegistry.shared.unregister(id: instance.id)
        }
        
        return instances.count
    }
    
    /// Soft delete (marks as hidden without removing)
    public static func softDelete(id: UUID) -> Result<Void, TitleBarError> {
        guard TitleBarRegistry.shared.getInstance(id: id) != nil else {
            return .failure(.invalidConfiguration)
        }
        
        TitleBarRegistry.shared.setState(.hidden, for: id)
        return .success(())
    }
}
