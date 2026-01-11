import Foundation

/// Collection of display data array
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct DisplayDataArray: Hashable, Codable {
    private var data: [Double]
    
    public init(_ data: [Double] = []) {
        self.data = data
    }
    
    public mutating func add(_ value: Double) {
        data.append(value)
    }
    
    public mutating func remove(at index: Int) {
        guard data.indices.contains(index) else { return }
        data.remove(at: index)
    }
    
    public var count: Int {
        data.count
    }
    
    public var average: Double {
        guard !data.isEmpty else { return 0 }
        return data.reduce(0, +) / Double(data.count)
    }
    
    public var min: Double? {
        data.min()
    }
    
    public var max: Double? {
        data.max()
    }
    
    public subscript(index: Int) -> Double {
        data[index]
    }
}
