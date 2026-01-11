import Foundation

/// Metadata dictionary collection for TitleBar
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TitleBarMetadata {
    private var data: [String: String]
    
    public init() {
        self.data = [:]
    }
    
    public init(data: [String: String]) {
        self.data = data
    }
    
    public subscript(key: String) -> String? {
        get { data[key] }
        set { data[key] = newValue }
    }
    
    public mutating func set(_ value: String, forKey key: String) {
        data[key] = value
    }
    
    public func get(_ key: String) -> String? {
        data[key]
    }
    
    public mutating func remove(_ key: String) {
        data.removeValue(forKey: key)
    }
    
    public var keys: [String] {
        Array(data.keys)
    }
    
    public var values: [String] {
        Array(data.values)
    }
    
    public var count: Int {
        data.count
    }
    
    public var isEmpty: Bool {
        data.isEmpty
    }
}
