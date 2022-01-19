//
//  StandardHapticFeedbackPlayer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(macOS)
import UIKit

/**
 This standard haptic feedback player uses system types when
 preparing and playing haptic feedback.
 
 You can use, modify and replace the ``shared`` player. This
 lets you customize the global haptic experience, where this
 standard player is used.
 
 Note that the player is currently only supported on certain
 platforms, where ``UIImpactFeedbackGenerator`` is available.
 System haptics could be used to remote this limitation.
 */
open class StandardHapticFeedbackPlayer: HapticFeedbackPlayer {
    
    public init() {}
    
    private var notificationGenerator = UINotificationFeedbackGenerator()
    private var lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
    private var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private var heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private var selectionGenerator = UISelectionFeedbackGenerator()
    
    /**
     Play a certain haptic feedback type.
     */
    open func play(_ feedback: HapticFeedback) {
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
    
    /**
     Prepare a certain haptic feedback type for being played.
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
}

public extension StandardHapticFeedbackPlayer {
    
    /**
     This shared instance is used on some platforms.
     */
    static var shared = StandardHapticFeedbackPlayer()
}

private extension StandardHapticFeedbackPlayer {
    
    func triggerNotification(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(notification)
    }
}
#endif
