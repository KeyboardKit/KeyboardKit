import Foundation

public extension HapticFeedback {
    
    @available(*, deprecated, message: "This property is no longer used")
    static var engine: HapticFeedbackEngine = {
        #if os(iOS)
        StandardHapticFeedbackEngine.shared
        #else
        DisabledHapticFeedbackEngine()
        #endif
    }()
}
