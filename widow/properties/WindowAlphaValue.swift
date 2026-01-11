import Foundation

/// The transparency level of the window (0.0 for fully transparent, 1.0 for fully opaque)
struct WindowAlphaValue {
    private var _value: CGFloat
    
    var value: CGFloat {
        get { _value }
        set { _value = min(max(newValue, 0.0), 1.0) }
    }
    
    init(_ alpha: CGFloat = 1.0) {
        self._value = min(max(alpha, 0.0), 1.0)
    }
}
