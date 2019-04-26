//
//  HapticFeedback.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-26.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public enum HapticFeedback: String {
    
    case
    error,
    success,
    warning,
    
    lightImpact,
    mediumImpact,
    heavyImpact,
    
    selectionChanged
    
    
    // MARK: - Properties
    
    public var identifier: String {
        return rawValue
    }
}


// MARK: - Public Functions

public extension HapticFeedback {
    
    static func prepare(_ feedback: HapticFeedback) {
        switch feedback {
        case .error, .success, .warning: notificationGenerator.prepare()
        case .lightImpact: lightImpactGenerator.prepare()
        case .mediumImpact: mediumImpactGenerator.prepare()
        case .heavyImpact: heavyImpactGenerator.prepare()
        case .selectionChanged: selectionGenerator.prepare()
        }
    }
    
    func prepare() {
        HapticFeedback.prepare(self)
    }
    
    static func trigger(_ feedback: HapticFeedback) {
        switch feedback {
        case .error: triggerNotification(.error)
        case .success: triggerNotification(.success)
        case .warning: triggerNotification(.warning)
        case .lightImpact: lightImpactGenerator.impactOccurred()
        case .mediumImpact: mediumImpactGenerator.impactOccurred()
        case .heavyImpact: heavyImpactGenerator.impactOccurred()
        case .selectionChanged: selectionGenerator.selectionChanged()
        }
    }
    
    func trigger() {
        HapticFeedback.trigger(self)
    }
}


// MARK: - Private Functions

private extension HapticFeedback {
    
    static func triggerNotification(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(notification)
    }
}


// MARK: - Private Generators

private extension HapticFeedback {
    
    private static var notificationGenerator = UINotificationFeedbackGenerator()
    private static var lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
    private static var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private static var heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private static var selectionGenerator = UISelectionFeedbackGenerator()
}
