import Foundation

/// Selection attribute for tabs
@available(iOS 13.0, tvOS 13.0, macOS 10.15, visionOS 1.0, watchOS 6.0, *)
public struct TabSelection: Hashable, Codable {
    public var selectedIndex: Int
    public var canSelectMultiple: Bool
    public var selectedIndices: Set<Int>
    
    public init(
        selectedIndex: Int = 0,
        canSelectMultiple: Bool = false,
        selectedIndices: Set<Int> = []
    ) {
        self.selectedIndex = selectedIndex
        self.canSelectMultiple = canSelectMultiple
        self.selectedIndices = canSelectMultiple ? selectedIndices : [selectedIndex]
    }
    
    public static let single = TabSelection(selectedIndex: 0, canSelectMultiple: false)
    public static let multiple = TabSelection(selectedIndex: 0, canSelectMultiple: true)
}
