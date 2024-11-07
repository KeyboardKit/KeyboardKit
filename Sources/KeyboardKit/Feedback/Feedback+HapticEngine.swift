#if os(iOS)
import UIKit
#endif

public extension Feedback {

    /// This engine can be used to trigger haptic feedback.
    ///
    /// The engine uses UIKit functionality that require iOS.
    /// Other platforms have no haptic feedback.
    class HapticEngine {
        
        public init() {}
        
        #if os(iOS)
        var notificationGenerator = UINotificationFeedbackGenerator()
        var lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
        var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
        var heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
        var selectionGenerator = UISelectionFeedbackGenerator()
        #endif
        
        /// Prepare a certain haptic feedback type.
        open func prepare(_ feedback: Feedback.Haptic) {
            #if os(iOS)
            switch feedback {
            case .error, .success, .warning: notificationGenerator.prepare()
            case .lightImpact: lightImpactGenerator.prepare()
            case .mediumImpact: mediumImpactGenerator.prepare()
            case .heavyImpact: heavyImpactGenerator.prepare()
            case .selectionChanged: selectionGenerator.prepare()
            case .none: return
            }
            #endif
        }
        
        /// Trigger a certain haptic feedback type.
        open func trigger(_ feedback: Feedback.Haptic) {
            #if os(iOS)
            switch feedback {
            case .error: triggerNotification(.error)
            case .success: triggerNotification(.success)
            case .warning: triggerNotification(.warning)
            case .lightImpact: lightImpactGenerator.impactOccurred()
            case .mediumImpact: mediumImpactGenerator.impactOccurred()
            case .heavyImpact: heavyImpactGenerator.impactOccurred()
            case .selectionChanged: selectionGenerator.selectionChanged()
            case .none: return
            }
            #endif
        }
    }
}

#if os(iOS)
private extension Feedback.HapticEngine {
    
    func triggerNotification(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(notification)
    }
}
#endif
