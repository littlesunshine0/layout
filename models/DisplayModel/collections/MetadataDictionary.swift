import Foundation

/// Collection of display metadata
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct DisplayMetadataDictionary: Hashable, Codable {
    private var metadata: [String: String]
    
    public init(_ metadata: [String: String] = [:]) {
        self.metadata = metadata
    }
    
    public subscript(key: String) -> String? {
        get { metadata[key] }
        set { metadata[key] = newValue }
    }
    
    public var keys: Dictionary<String, String>.Keys {
        metadata.keys
    }
    
    public var values: Dictionary<String, String>.Values {
        metadata.values
    }
    
    public var count: Int {
        metadata.count
    }
    
    public mutating func removeValue(forKey key: String) {
        metadata.removeValue(forKey: key)
    }
}
