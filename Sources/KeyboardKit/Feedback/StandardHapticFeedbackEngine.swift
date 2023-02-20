//
//  StandardHapticFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import UIKit

/**
 This engine uses system features to trigger haptic feedback.
 It's the default ``HapticFeedback/engine`` on all platforms
 where it's supported.

 You can use, modify and replace the ``shared`` engine. This
 lets you customize the global haptic feedback experience.
 
 Note that that haptic feedback requires full access.
 */
open class StandardHapticFeedbackEngine: HapticFeedbackEngine {
    
    public init() {}
    
    private var notificationGenerator = UINotificationFeedbackGenerator()
    private var lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
    private var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private var heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private var selectionGenerator = UISelectionFeedbackGenerator()
    
    /**
     Prepare a certain haptic feedback type.
     */
    open func prepare(_ feedback: HapticFeedback) {
        switch feedback {
        case .error, .success, .warning: notificationGenerator.prepare()
        case .lightImpact: lightImpactGenerator.prepare()
        case .mediumImpact: mediumImpactGenerator.prepare()
        case .heavyImpact: heavyImpactGenerator.prepare()
        case .selectionChanged: selectionGenerator.prepare()
        case .none: return
        }
    }

    /**
     Trigger a certain haptic feedback type.
     */
    open func trigger(_ feedback: HapticFeedback) {
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
    }
}

public extension StandardHapticFeedbackEngine {
    
    /**
     A shared instance that can be used from anywhere.
     */
    static var shared = StandardHapticFeedbackEngine()
}

private extension StandardHapticFeedbackEngine {
    
    func triggerNotification(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(notification)
    }
}
#endif
