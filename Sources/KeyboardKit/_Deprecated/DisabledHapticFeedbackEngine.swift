import Foundation

@available(*, deprecated, message: "This engine is no longer used.")
public class DisabledHapticFeedbackEngine: HapticFeedbackEngine {
    
    public override func prepare(_ feedback: HapticFeedback) {}
    public override func trigger(_ feedback: HapticFeedback) {}
}
