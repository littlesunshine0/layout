import Foundation

/// Collection of controls array
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct ControlsArray: Hashable, Codable {
    private var controls: [UUID]
    
    public init(_ controls: [UUID] = []) {
        self.controls = controls
    }
    
    public mutating func add(_ controlId: UUID) {
        controls.append(controlId)
    }
    
    public mutating func remove(_ controlId: UUID) {
        controls.removeAll { $0 == controlId }
    }
    
    public func contains(_ controlId: UUID) -> Bool {
        controls.contains(controlId)
    }
    
    public var count: Int {
        controls.count
    }
    
    public subscript(index: Int) -> UUID {
        controls[index]
    }
}
