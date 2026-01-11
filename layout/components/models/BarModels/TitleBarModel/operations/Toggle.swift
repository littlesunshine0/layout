import Foundation

/// Title bar toggle operation
/// Handles toggling of title bar states and properties
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public struct TitleBarToggleOperation {
    
    /// Toggles title bar visibility
    public static func toggleVisibility(for id: UUID) -> Result<TitleBarState, TitleBarError> {
        guard let currentState = TitleBarRegistry.shared.getState(for: id) else {
            return .failure(.invalidConfiguration)
        }
        
        let newState: TitleBarState = currentState == .hidden ? .active : .hidden
        TitleBarRegistry.shared.setState(newState, for: id)
        
        return .success(newState)
    }
    
    /// Toggles title bar buttons visibility
    public static func toggleButtons(for id: UUID) -> Result<Bool, TitleBarError> {
        guard let instance = TitleBarRegistry.shared.getInstance(id: id) else {
            return .failure(.invalidConfiguration)
        }
        
        instance.configuration.showsButtons.toggle()
        return .success(instance.configuration.showsButtons)
    }
    
    /// Toggles between collapsed and expanded states
    public static func toggleExpansion(for id: UUID) -> Result<TitleBarState, TitleBarError> {
        guard let currentState = TitleBarRegistry.shared.getState(for: id) else {
            return .failure(.invalidConfiguration)
        }
        
        let newState: TitleBarState = currentState == .collapsed ? .expanded : .collapsed
        TitleBarRegistry.shared.setState(newState, for: id)
        
        return .success(newState)
    }
    
    /// Toggles active/inactive state
    public static func toggleActive(for id: UUID) -> Result<TitleBarState, TitleBarError> {
        guard let currentState = TitleBarRegistry.shared.getState(for: id) else {
            return .failure(.invalidConfiguration)
        }
        
        let newState: TitleBarState = currentState == .active ? .inactive : .active
        TitleBarRegistry.shared.setState(newState, for: id)
        
        return .success(newState)
    }
}
