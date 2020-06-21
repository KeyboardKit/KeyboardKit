//
//  KeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

/**
 This protocol can be implemented by any classes that can be
 used to provide the keyboard extension with contextual info.
 */
public protocol KeyboardContext: AnyObject {
    
    /**
     This handler can be used to handle any keyboard actions
     that are triggered by the user or the system. It can be
     replaced with any custom action handler.
     */
    var actionHandler: KeyboardActionHandler { get set }
    
    /**
     Whether or not the keyboard extension has full access.
     
     Full access is required to access the pasteboard or the
     photo library, to provide audio and haptic feedback etc.
     */
    var hasFullAccess: Bool { get set }
    
    /**
     The current keyboard type, which can be used in any way
     you like. It has no built-in logic, but you can use the
     current state to determine which keyboard to provide to
     the user.
     */
    var keyboardType: KeyboardType { get set }
    
    /**
     Whether or not the keyboard extension most provide your
     current user with an inpurt mode switch key, which is a
     globe shaped key that switches keyboard when tapped and
     shows a keyboard menu when pressed.
     */
    var needsInputModeSwitchKey: Bool { get set }
}

public extension KeyboardContext {
    
    /**
     This function changes keyboard type, using the standard
     system behavior, where some changes may be ignored. For
     instance, it is not possible to change from caps locked
     keyboards to upper-case ones.
     
     The delay can be used to allow a double-tap action time
     to finish before changing the keyboard.
     */
    func changeKeyboardType(to type: KeyboardType, after delay: DispatchTimeInterval, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.changeKeyboardTypeAfterDelay(to: type, completion: completion)
        }
    }
}

private extension KeyboardContext {
    
    func changeKeyboardTypeAfterDelay(to type: KeyboardType, completion: @escaping () -> Void) {
        guard keyboardType.canBeReplaced(with: type) else { return }
        keyboardType = type
        completion()
    }
}
