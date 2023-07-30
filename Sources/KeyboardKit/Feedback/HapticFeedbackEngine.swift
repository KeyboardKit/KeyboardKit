//
//  HapticFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import UIKit
#endif

/**
 This engine can be used to trigger haptic feedback.
 
 This engine uses `UIKit` components that are only available
 on iOS. Therefore, it does nothing on other platforms.
 */
open class HapticFeedbackEngine {
    
    /// Create a haptic feedback engine instance.
    public init() {}
    
    #if os(iOS)
    var notificationGenerator = UINotificationFeedbackGenerator()
    var lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
    var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    var heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    var selectionGenerator = UISelectionFeedbackGenerator()
    #endif
    
    /// Prepare a certain haptic feedback type.
    open func prepare(_ feedback: HapticFeedback) {
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
    open func trigger(_ feedback: HapticFeedback) {
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

public extension HapticFeedbackEngine {
    
    /// This shared instance can be used from anywhere.
    static var shared = HapticFeedbackEngine()
}

#if os(iOS)
private extension HapticFeedbackEngine {
    
    func triggerNotification(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(notification)
    }
}
#endif
