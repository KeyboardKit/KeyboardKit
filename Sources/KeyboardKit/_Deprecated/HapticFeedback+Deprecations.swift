import Foundation

public extension HapticFeedback {

    @available(*, deprecated, message: "Use haptic configuration from now on")
    static var standardTapFeedback: HapticFeedback { .lightImpact }

    @available(*, deprecated, message: "Use haptic configuration from now on")
    static var standardDoubleTapFeedback: HapticFeedback { .mediumImpact }
    
    @available(*, deprecated, message: "Use haptic configuration from now on")
    static var standardLongPressFeedback: HapticFeedback { .heavyImpact }
    
    @available(*, deprecated, message: "Use haptic configuration from now on")
    static var standardLongPressSpace: HapticFeedback { .heavyImpact }
}
