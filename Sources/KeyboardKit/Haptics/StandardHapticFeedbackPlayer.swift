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
 */
public class StandardHapticFeedbackPlayer: HapticFeedbackPlayer {
    
    public init() {}
    
    private var notificationGenerator = UINotificationFeedbackGenerator()
    private var lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
    private var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private var heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private var selectionGenerator = UISelectionFeedbackGenerator()
    
    /**
     Play a certain haptic feedback type.
     */
    public func play(_ feedback: HapticFeedback) {
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
    public func prepare(_ feedback: HapticFeedback) {
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
     The standard player that is used for haptic feedback.
     */
    static var shared: HapticFeedbackPlayer = StandardHapticFeedbackPlayer()
}

private extension StandardHapticFeedbackPlayer {
    
    func triggerNotification(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(notification)
    }
}
#endif
